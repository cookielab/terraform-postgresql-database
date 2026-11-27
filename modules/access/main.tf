locals {
  password_write_only = var.password_wo_version != null
  role_name           = var.create_role ? postgresql_role.this[0].name : var.role_name
}

resource "random_password" "this" {
  count = var.allow_login && !local.password_write_only ? 1 : 0

  length           = 32
  special          = false
  override_special = "_%"
}

resource "postgresql_role" "this" {
  count = var.create_role ? 1 : 0

  name                = var.role_name
  login               = var.allow_login
  password            = var.allow_login && !local.password_write_only ? random_password.this[0].result : null
  password_wo         = var.allow_login && local.password_write_only ? var.password_wo : null
  password_wo_version = var.allow_login ? var.password_wo_version : null
}

resource "postgresql_grant" "tables" {
  for_each = var.schemas

  database    = var.database_name
  role        = local.role_name
  schema      = each.value
  object_type = "table"
  privileges  = var.access_map.table_rights
}

resource "postgresql_grant" "schema" {
  for_each = var.schemas

  database    = var.database_name
  role        = local.role_name
  schema      = each.value
  object_type = "schema"
  privileges  = var.access_map.schema_rights
}

resource "postgresql_grant" "database" {
  database    = var.database_name
  role        = local.role_name
  schema      = "public"
  object_type = "database"
  privileges  = var.access_map.database_rights
}

resource "postgresql_grant" "sequence" {
  for_each = var.schemas

  database    = var.database_name
  role        = local.role_name
  schema      = each.value
  object_type = "sequence"
  privileges  = var.access_map.sequence_rights
}

# Default privileges for objects created later by the database owner (FOR ROLE owner IN SCHEMA each.value).
resource "postgresql_default_privileges" "tables" {
  for_each = var.schemas

  database    = var.database_name
  role        = local.role_name
  schema      = each.value
  object_type = "table"
  privileges  = var.access_map.table_rights
  owner       = var.database_owner
}

resource "postgresql_default_privileges" "sequences" {
  for_each = var.schemas

  database    = var.database_name
  role        = local.role_name
  schema      = each.value
  object_type = "sequence"
  privileges  = var.access_map.sequence_rights
  owner       = var.database_owner
}
