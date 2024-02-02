module "database" {
  source = "./database"

  database_name             = var.database_name
  database_private_hostname = var.database_private_hostname
}

module "user" {
  source = "./user"

  username = var.username
  roles    = var.roles
}

module "access" {
  source = "./access"

  database_name      = var.database_name
  database_owner     = var.database_owner
  create_access_user = var.create_access_user
  access_user        = var.access_user
  access_map         = var.access_map
}


