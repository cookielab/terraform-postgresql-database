terraform {
  backend "local" {
  }
}

locals {
  databases = {
    project_development = {
      owner        = "custom_owner"
      app_username = "custom_app"
      role_ro_name = "custom_reader"
      role_rw_name = "custom_writer"
    }
    project_staging = {}
  }

  users = {
    joedoe = {
      roles = [
        "custom_writer",
        "project_staging_rw",
      ]
    }
    karensmith = {
      roles = [
        "custom_reader",
        "project_staging_ro",
      ]
    }
  }
}

provider "postgresql" {
  host            = "localhost"
  port            = "5432"
  superuser       = false
  database        = "postgres"
  username        = "jindraj"
  password        = ""
  sslmode         = "disable"
  connect_timeout = 15
}

module "database" {
  for_each = local.databases
  source   = "../.."

  database       = each.key
  owner_username = try(each.value.owner, null)
  app_username   = try(each.value.app_username, null)
  role_ro_name   = try(each.value.role_ro_name, null)
  role_rw_name   = try(each.value.role_rw_name, null)
}

module "users" {
  for_each = local.users
  source   = "../..//user"

  username = each.key
  roles    = each.value.roles
}
