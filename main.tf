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
  source = "./database"

  database_name  = var.database
  owner_username = var.owner_username
}

module "access_ro" {
  source = "./access"

  database_name  = var.database
  database_owner = module.database.username
  role_name      = var.role_ro_name != null ? var.role_ro_name : "${var.database}_ro"
  create_role    = true
  allow_login    = false
  access_map     = local.access_map_ro
  depends_on     = [module.database]
}

module "access_rw" {
  source = "./access"

  database_name  = var.database
  database_owner = module.database.username
  role_name      = var.role_rw_name != null ? var.role_rw_name : "${var.database}_rw"
  create_role    = true
  allow_login    = false
  access_map     = local.access_map_rw
  depends_on     = [module.database]
}

module "access_app" {
  source = "./access"

  database_name  = var.database
  database_owner = module.database.username
  role_name      = var.app_username != null ? var.app_username : "${var.database}_app"
  create_role    = true
  allow_login    = true
  access_map     = local.access_map_rw
  depends_on     = [module.database]
}
