module "database" {
  source = "./database"

  database_name  = var.database
  owner_username = var.owner
}

module "access_ro" {
  source = "./access_rw"

  database_name  = var.database
  database_owner = var.owner
  create_role    = var.create_role
  role_name      = "${var.database}_ro"
  allow_login    = false
  depends_on     = [module.database]
}

module "access_rw" {
  source = "./access_ro"

  database_name  = var.database
  database_owner = var.owner
  create_role    = var.create_role
  role_name      = "${var.database}_rw"
  allow_login    = false
  depends_on     = [module.database]
}

module "access_app" {
  source = "./access_rw"

  database_name  = var.database
  database_owner = var.owner
  create_role    = var.create_role
  role_name      = "${var.database}_app"
  allow_login    = var.allow_login
  depends_on     = [module.database]
}
