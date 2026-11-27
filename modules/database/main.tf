resource "random_password" "owner" {
  length           = 32
  special          = false
  override_special = "_%"
}

resource "postgresql_role" "owner" {
  name     = var.owner_username == null ? "${var.database_name}_migrator" : var.owner_username
  login    = true
  password = random_password.owner.result
}

resource "postgresql_database" "this" {
  name              = var.database_name
  owner             = postgresql_role.owner.name
  template          = var.template
  lc_collate        = var.lc_collate
  lc_ctype          = var.lc_ctype
  encoding          = var.encoding
  connection_limit  = -1
  allow_connections = true
}

resource "postgresql_extension" "pg_trgm" {
  name     = "pg_trgm"
  database = postgresql_database.this.name
}

resource "postgresql_extension" "uuid_ossp" {
  name     = "uuid-ossp"
  database = postgresql_database.this.name
}

resource "postgresql_schema" "this" {
  for_each = toset([for schema in var.schemas : schema if schema != "public"])

  name     = each.key
  database = postgresql_database.this.name
  owner    = postgresql_role.owner.name
}
