terraform {
  backend "local" {
  }
}

locals {
  databases = {
    project_development = {
      owner = "custom_owner"
    }
    project_staging = {
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

  database       = each.key
  owner_username = try(each.value.owner, "${each.key}_migrator")
  #user_role   = local.users #merge(local.databases, local.users)
}
