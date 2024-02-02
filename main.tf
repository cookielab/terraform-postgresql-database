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
  source = "./database"

  for_each = var.databases

  database_name             = each.value.database
  database_private_hostname = var.database_private_hostname
}

module "user" {
  source = "./user"

  for_each = var.user_role

  username = each.key
  roles    = each.value.roles
  depends_on = [
    module.access_rw,
    module.access_ro,
  ]

}

module "access_rw" {
  source = "./access"

  for_each = var.databases

  database_name      = each.value.database
  database_owner     = module.database[each.key].database_owner.username
  create_access_user = var.create_access_user
  access_user        = "${each.value.database}_readwrite"
  access_map         = local.database_readwrite_rights
  depends_on = [module.database]
}

module "access_ro" {
  source = "./access"

  for_each = var.databases

  database_name      = each.value.database
  database_owner     = module.database[each.key].database_owner.username
  create_access_user = var.create_access_user
  access_user        = "${each.value.database}_readonly"
  access_map         = local.database_readonly_rights
  depends_on = [module.database]
}
