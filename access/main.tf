resource "postgresql_role" "this" {
  count = var.create_role ? 1 : 0
  name  = var.role_name
}

resource "postgresql_grant" "tables" {

  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "table"
  privileges  = var.access_map.table_rights
}

resource "postgresql_grant" "schema" {

  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "schema"
  privileges  = var.access_map.schema_rights
}

resource "postgresql_grant" "database" {

  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "database"
  privileges  = var.access_map.database_rights
}

resource "postgresql_grant" "sequence" {

  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "sequence"
  privileges  = var.access_map.sequence_rights
}

resource "postgresql_default_privileges" "tables" {

  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "table"
  privileges  = var.access_map.table_rights
  owner       = var.database_owner
}

resource "postgresql_default_privileges" "sequences" {
  database    = var.database_name
  role        = var.create_role ? postgresql_role.this[0].name : var.role_name
  schema      = "public"
  object_type = "sequence"
  privileges  = var.access_map.sequence_rights
  owner       = var.database_owner

}
