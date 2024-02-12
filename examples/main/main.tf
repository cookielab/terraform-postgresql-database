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

  #  users = {
  #    joedoe = {
  #      roles = [
  #        "project_development_rw",
  #        "project_staging_ro",
  #      ]
  #    }
  #    karensmith = {
  #      roles = [
  #        "project_development_rw",
  #      ]
  #    }
  #  }
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
  #user_role   = local.users #merge(local.databases, local.users)
}
