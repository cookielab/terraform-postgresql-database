locals {
  database_readonly_rights = {
    table_rights    = ["SELECT"]
    sequence_rights = ["USAGE"]
    schema_rights   = ["USAGE"]
    database_rights = ["CONNECT"]
  }
  database_readwrite_rights = {
    table_rights    = ["SELECT", "UPDATE", "INSERT", "DELETE", "TRIGGER", "REFERENCES", "TRUNCATE"]
    sequence_rights = ["SELECT", "UPDATE"]
    schema_rights   = ["USAGE"],
    database_rights = ["CONNECT"],
  }
}

module "database" {
  for_each = var.databases

  source = "./database"

  database_name             = each.value.database
  database_private_hostname = var.database_private_hostname
}

module "access_rw" {
  for_each = var.databases

  source = "./access"

  database_name      = each.value.database
  database_owner     = module.database[each.key].database_owner.username
  create_access_user = var.create_access_user
  access_user        = "${each.value.database}_readwrite"
  access_map         = local.database_readwrite_rights
  depends_on         = [module.database]
}

module "access_ro" {
  for_each = var.databases

  source = "./access"

  database_name      = each.value.database
  database_owner     = module.database[each.key].database_owner.username
  create_access_user = var.create_access_user
  access_user        = "${each.value.database}_readonly"
  access_map         = local.database_readonly_rights
  depends_on         = [module.database]
}

module "user" {
  for_each = var.user_role

  source = "./user"

  username = each.key
  roles    = each.value.roles
  depends_on = [
    module.access_rw,
    module.access_ro,
  ]
}
