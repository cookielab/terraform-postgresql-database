locals {
  access_map_ro = {
    table_rights    = ["SELECT"]
    sequence_rights = ["USAGE"]
    schema_rights   = ["USAGE"]
    database_rights = ["CONNECT"]
  }
  access_map_rw = {
    table_rights    = ["SELECT", "UPDATE", "INSERT", "DELETE", "TRIGGER", "REFERENCES", "TRUNCATE"]
    sequence_rights = ["SELECT", "UPDATE"]
    schema_rights   = ["USAGE"],
    database_rights = ["CONNECT"],
  }
}

module "database" {
  source = "./modules/database"

  database_name  = var.database
  owner_username = var.owner_username
  template       = var.template
  encoding       = var.encoding
  lc_collate     = var.lc_collate
  lc_ctype       = var.lc_ctype
  schemas        = var.schemas

  password_wo         = var.owner_password_wo
  password_wo_version = var.owner_password_wo_version
}

# The access modules run one after another (ro -> rw -> app): the provider locks
# grants only per role, so concurrent GRANT/REVOKE on the same schema fails with
# "tuple concurrently updated" (https://github.com/cyrilgdn/terraform-provider-postgresql/issues/178).
# Once a provider release fixes it, raise the cyrilgdn/postgresql constraint in
# versions.tf to that version and drop both depends_on.
module "access_ro" {
  source = "./modules/access"

  database_name  = module.database.database_name
  database_owner = module.database.username
  schemas        = module.database.schemas
  role_name      = var.role_ro_name != null ? var.role_ro_name : "${var.database}_ro"
  create_role    = var.create_role_ro
  allow_login    = false
  access_map     = local.access_map_ro
}

module "access_rw" {
  source = "./modules/access"

  database_name  = module.database.database_name
  database_owner = module.database.username
  schemas        = module.database.schemas
  role_name      = var.role_rw_name != null ? var.role_rw_name : "${var.database}_rw"
  create_role    = var.create_role_rw
  allow_login    = false
  access_map     = local.access_map_rw

  depends_on = [module.access_ro]
}

module "access_app" {
  source = "./modules/access"

  database_name  = module.database.database_name
  database_owner = module.database.username
  schemas        = module.database.schemas
  role_name      = var.app_username != null ? var.app_username : "${var.database}_app"
  create_role    = true
  allow_login    = true
  access_map     = local.access_map_rw

  password_wo         = var.app_password_wo
  password_wo_version = var.app_password_wo_version

  depends_on = [module.access_rw]
}
