terraform {
  backend "local" {
  }
}


locals {
  databases = {
    project_development_app = {
      database = "project_development"
      roles = [
        "project_development_rw",
      ]
    }
    project_staging_app = {
      database = "project_staging"
      roles = [
        "project_staging_rw",
      ]
    }
  }

  users = {
    joedoe = {
      roles = [
        "project_development_rw",
        "project_staging_ro",
      ]
    }
    karensmith = {
      roles = [
        "project_development_rw",
      ]
    }
  }
}

provider "postgresql" {
  host            = "localhost"
  port            = "5432"
  superuser       = false
  database        = "postgres"
  username        = "postgres"
  password        = ""
  sslmode         = "disable"
  connect_timeout = 15
}

module "database" {
  source = "../.."

  databases   = local.databases
  user_role   = merge(local.databases, local.users)
  create_role = true
}
