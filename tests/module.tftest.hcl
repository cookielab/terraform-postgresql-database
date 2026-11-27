mock_provider "postgresql" {}
mock_provider "random" {}

variables {
  database = "app"
}

run "defaults" {
  command = plan

  module {
    source = "./tests/fixtures/root"
  }

  assert {
    condition     = output.database_name == "app"
    error_message = "Unexpected database name."
  }

  assert {
    condition     = nonsensitive(output.owner_user.username == "app_migrator" && output.app_user.username == "app_app")
    error_message = "Unexpected default role names."
  }

  assert {
    condition     = output.roles == ["app_ro", "app_rw"]
    error_message = "Unexpected ro/rw role names."
  }
}

run "database_defaults" {
  command = plan

  module {
    source = "./modules/database"
  }

  variables {
    database_name = "app"
  }

  assert {
    condition = (
      postgresql_database.this.template == "template0" &&
      postgresql_database.this.encoding == "UTF8" &&
      postgresql_database.this.lc_collate == "en_US.UTF-8" &&
      postgresql_database.this.lc_ctype == "en_US.UTF-8"
    )
    error_message = "Database defaults must stay template0 / UTF8 / en_US.UTF-8."
  }

  assert {
    condition     = length(postgresql_schema.this) == 0
    error_message = "The public schema must not be created."
  }

  assert {
    condition     = output.schemas == { public = "public" }
    error_message = "Default schemas must be public only."
  }

  assert {
    condition     = length(random_password.owner) == 1 && postgresql_role.owner.password_wo_version == null
    error_message = "Without a write-only version the generated password must be used."
  }
}

run "database_schemas_and_locale" {
  command = plan

  module {
    source = "./modules/database"
  }

  variables {
    database_name = "app"
    schemas       = ["public", "app_schema"]
    lc_collate    = "C.UTF-8"
    lc_ctype      = "C.UTF-8"
  }

  assert {
    condition     = keys(postgresql_schema.this) == ["app_schema"]
    error_message = "Only non-public schemas must be created."
  }

  assert {
    condition = (
      postgresql_schema.this["app_schema"].owner == "app_migrator" &&
      postgresql_schema.this["app_schema"].database == "app"
    )
    error_message = "Schema must be owned by the owner role in the database."
  }

  assert {
    condition     = postgresql_database.this.lc_collate == "C.UTF-8" && postgresql_database.this.lc_ctype == "C.UTF-8"
    error_message = "Locale variables are not passed to the database."
  }
}

run "database_duplicate_schemas" {
  command = plan

  module {
    source = "./modules/database"
  }

  variables {
    database_name = "app"
    schemas       = ["public", "public"]
  }

  expect_failures = [var.schemas]
}

run "database_null_schema_name" {
  command = plan

  module {
    source = "./modules/database"
  }

  variables {
    database_name = "app"
    schemas       = ["public", null]
  }

  expect_failures = [var.schemas]
}

run "access_schemas" {
  command = plan

  module {
    source = "./modules/access"
  }

  variables {
    database_name  = "app"
    database_owner = "app_migrator"
    role_name      = "app_ro"
    create_role    = true
    allow_login    = false
    schemas        = { public = "public", app_schema = "app_schema" }
    access_map = {
      table_rights    = ["SELECT"]
      sequence_rights = ["USAGE"]
      schema_rights   = ["USAGE"]
      database_rights = ["CONNECT"]
    }
  }

  assert {
    condition = alltrue([
      for r in [postgresql_grant.tables, postgresql_grant.schema, postgresql_grant.sequence, postgresql_default_privileges.tables, postgresql_default_privileges.sequences] :
      keys(r) == ["app_schema", "public"]
    ])
    error_message = "Grants and default privileges must exist for every schema."
  }

  assert {
    condition = alltrue([
      for k, v in postgresql_default_privileges.tables : v.owner == "app_migrator" && v.schema == k && v.role == "app_ro"
    ])
    error_message = "Default privileges must be FOR ROLE owner IN SCHEMA each schema."
  }

  assert {
    condition     = postgresql_grant.database.object_type == "database"
    error_message = "Database grant must stay a single resource."
  }
}

run "access_schemas_empty" {
  command = plan

  module {
    source = "./modules/access"
  }

  variables {
    database_name  = "app"
    database_owner = "app_migrator"
    role_name      = "app_ro"
    create_role    = true
    allow_login    = false
    schemas        = {}
    access_map = {
      table_rights    = ["SELECT"]
      sequence_rights = ["USAGE"]
      schema_rights   = ["USAGE"]
      database_rights = ["CONNECT"]
    }
  }

  expect_failures = [var.schemas]
}

run "write_only_passwords" {
  command = plan

  module {
    source = "./tests/fixtures/root"
  }

  variables {
    owner_password_wo         = "owner-secret"
    owner_password_wo_version = "1"
    app_password_wo           = "app-secret"
    app_password_wo_version   = "1"
  }

  assert {
    condition     = nonsensitive(output.owner_user.password == null && output.app_user.password == null)
    error_message = "Passwords must not be returned when write-only passwords are used."
  }
}

# Same arguments as the root module passes to module.access_app.
run "write_only_password_access_app" {
  command = plan

  module {
    source = "./modules/access"
  }

  variables {
    database_name       = "app"
    database_owner      = "app_migrator"
    role_name           = "app_app"
    create_role         = true
    allow_login         = true
    password_wo         = "app-secret"
    password_wo_version = "1"
    access_map = {
      table_rights    = ["SELECT"]
      sequence_rights = ["USAGE"]
      schema_rights   = ["USAGE"]
      database_rights = ["CONNECT"]
    }
  }

  assert {
    condition     = length(random_password.this) == 0
    error_message = "No random_password must be created for the app role in write-only mode."
  }

  assert {
    condition     = postgresql_role.this[0].password == null && postgresql_role.this[0].password_wo_version == "1"
    error_message = "The app role must use password_wo instead of password."
  }

  assert {
    condition     = output.password == null
    error_message = "The app role password must not be returned in write-only mode."
  }
}

run "write_only_password_database_module" {
  command = plan

  module {
    source = "./modules/database"
  }

  variables {
    database_name       = "app"
    password_wo         = "owner-secret"
    password_wo_version = "1"
  }

  assert {
    condition     = length(random_password.owner) == 0
    error_message = "No random_password must be stored in state in write-only mode."
  }

  assert {
    condition     = postgresql_role.owner.password == null && postgresql_role.owner.password_wo_version == "1"
    error_message = "The role must use password_wo instead of password."
  }
}

run "write_only_password_requires_both" {
  command = plan

  module {
    source = "./modules/user"
  }

  variables {
    username            = "joe"
    roles               = []
    password_wo_version = "1"
  }

  expect_failures = [var.password_wo_version]
}

# Root module variables are validated in runs without a module block, i.e. against
# the root module itself. A root module cannot output sensitive values, so the runs
# also make the owner (and app) password inputs invalid on purpose: that stops
# Terraform before it evaluates the owner_user / app_user outputs. Every listed
# expected failure must occur for a run to pass.
run "root_owner_password_wo_requires_both" {
  command = plan

  variables {
    app_password_wo           = "app-secret"
    app_password_wo_version   = "1"
    owner_password_wo_version = "1"
  }

  expect_failures = [var.owner_password_wo_version]
}

run "root_owner_password_wo_not_empty" {
  command = plan

  variables {
    app_password_wo           = "app-secret"
    app_password_wo_version   = "1"
    owner_password_wo         = ""
    owner_password_wo_version = "1"
  }

  expect_failures = [var.owner_password_wo]
}

run "root_app_password_wo_requires_both" {
  command = plan

  variables {
    owner_password_wo_version = "1"
    app_password_wo           = "app-secret"
  }

  expect_failures = [var.app_password_wo_version, var.owner_password_wo_version]
}

run "root_app_password_wo_not_empty" {
  command = plan

  variables {
    owner_password_wo_version = "1"
    app_password_wo           = ""
    app_password_wo_version   = "1"
  }

  expect_failures = [var.app_password_wo, var.owner_password_wo_version]
}

run "root_schemas_empty" {
  command = plan

  variables {
    owner_password_wo_version = "1"
    app_password_wo_version   = "1"
    schemas                   = []
  }

  expect_failures = [var.schemas, var.owner_password_wo_version, var.app_password_wo_version]
}

run "root_schemas_blank_name" {
  command = plan

  variables {
    owner_password_wo_version = "1"
    app_password_wo_version   = "1"
    schemas                   = ["public", " "]
  }

  expect_failures = [var.schemas, var.owner_password_wo_version, var.app_password_wo_version]
}

run "root_schemas_duplicate" {
  command = plan

  variables {
    owner_password_wo_version = "1"
    app_password_wo_version   = "1"
    schemas                   = ["public", "app", "app"]
  }

  expect_failures = [var.schemas, var.owner_password_wo_version, var.app_password_wo_version]
}

run "access_password_wo_not_empty" {
  command = plan

  module {
    source = "./modules/access"
  }

  variables {
    database_name       = "app"
    database_owner      = "app_migrator"
    role_name           = "app_app"
    create_role         = true
    allow_login         = true
    password_wo         = ""
    password_wo_version = "1"
    access_map = {
      table_rights    = ["SELECT"]
      sequence_rights = ["USAGE"]
      schema_rights   = ["USAGE"]
      database_rights = ["CONNECT"]
    }
  }

  expect_failures = [var.password_wo]
}

run "database_password_wo_not_empty" {
  command = plan

  module {
    source = "./modules/database"
  }

  variables {
    database_name       = "app"
    password_wo         = ""
    password_wo_version = "1"
  }

  expect_failures = [var.password_wo]
}

run "user_password_wo_not_empty" {
  command = plan

  module {
    source = "./modules/user"
  }

  variables {
    username            = "joe"
    roles               = []
    password_wo         = ""
    password_wo_version = "1"
  }

  expect_failures = [var.password_wo]
}
