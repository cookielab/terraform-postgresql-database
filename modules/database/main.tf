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
  template          = "template0"
  lc_collate        = "en_US.UTF-8"
  lc_ctype          = "en_US.UTF-8"
  encoding          = "UTF8"
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
