locals {
  access_map = {
    table_rights    = ["SELECT"]
    sequence_rights = ["USAGE"]
    schema_rights   = ["USAGE"]
    database_rights = ["CONNECT"]
  }
}

resource "random_password" "this" {
  count = var.allow_login ? 1 : 0

  length           = 32
  special          = false
  override_special = "_%"
}

resource "postgresql_role" "this" {
  count = var.create_role ? 1 : 0

  name     = var.role_name
  login    = var.allow_login
  password = var.allow_login ? random_password.this[0].result : null
}

resource "postgresql_grant" "tables" {

  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "table"
  privileges  = local.access_map.table_rights
}

resource "postgresql_grant" "schema" {

  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "schema"
  privileges  = local.access_map.schema_rights
}

resource "postgresql_grant" "database" {

  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "database"
  privileges  = local.access_map.database_rights
}

resource "postgresql_grant" "sequence" {

  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "sequence"
  privileges  = local.access_map.sequence_rights
}

resource "postgresql_default_privileges" "tables" {

  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "table"
  privileges  = local.access_map.table_rights
  owner       = var.database_owner
}

resource "postgresql_default_privileges" "sequences" {
  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "sequence"
  privileges  = local.access_map.sequence_rights
  owner       = var.database_owner

}
