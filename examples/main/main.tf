terraform {
  backend "local" {
  }
}

locals {
  databases = {
    project_development = {
      owner       = "custom_owner"
      allow_login = true
    }
    project_staging = {
      allow_login = false
    }
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

  allow_login = each.value.allow_login
  database    = each.key
  owner       = try(each.value.owner, "${each.key}_migrator")
  create_role = true
  #user_role   = local.users #merge(local.databases, local.users)
}
