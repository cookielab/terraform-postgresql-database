resource "random_password" "db_password" {
  length           = 32
  special          = false
  override_special = "_%"
}

resource "postgresql_role" "owner_role" {
  name     = "${var.database_name}_migrator"
  login    = true
  password = random_password.db_password.result
}

resource "postgresql_database" "database" {
  name              = var.database_name
  owner             = postgresql_role.owner_role.name
  template          = "template0"
  lc_collate        = "en_US.UTF-8"
  lc_ctype          = "en_US.UTF-8"
  encoding          = "UTF8"
  connection_limit  = -1
  allow_connections = true
}

resource "postgresql_extension" "pg_trgm" {
  name     = "pg_trgm"
  database = postgresql_database.database.name
}

resource "postgresql_extension" "uuid_ossp" {
  name     = "uuid-ossp"
  database = postgresql_database.database.name
}
