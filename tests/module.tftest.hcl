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
}

run "database_locale" {
  command = plan

  module {
    source = "./modules/database"
  }

  variables {
    database_name = "app"
    lc_collate    = "C.UTF-8"
    lc_ctype      = "C.UTF-8"
  }

  assert {
    condition     = postgresql_database.this.lc_collate == "C.UTF-8" && postgresql_database.this.lc_ctype == "C.UTF-8"
    error_message = "Locale variables are not passed to the database."
  }
}
