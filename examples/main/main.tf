terraform {
  backend "local" {
  }
}

locals {
  app_password_version = 1

  databases = {
    project_development = {
      owner        = "custom_owner"
      app_username = "custom_app"
      role_ro_name = "custom_reader"
      role_rw_name = "custom_writer"
    }
    project_staging = {
      schemas = ["public", "app"]
    }
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

# Write-only password of the application user: generated on every run and never
# stored in state. It is written to the role and to the Kubernetes secret only
# when the version changes. Both versions come from app_password_version so they
# always change together; bump it to rotate the password.
ephemeral "random_password" "app" {
  for_each = local.databases

  length  = 32
  special = false
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "database" {
  for_each = local.databases
  source   = "../.."

  database       = each.key
  owner_username = try(each.value.owner, null)
  app_username   = try(each.value.app_username, null)
  role_ro_name   = try(each.value.role_ro_name, null)
  role_rw_name   = try(each.value.role_rw_name, null)
  schemas        = try(each.value.schemas, ["public"])

  app_password_wo         = ephemeral.random_password.app[each.key].result
  app_password_wo_version = tostring(local.app_password_version)
}

resource "kubernetes_secret_v1" "app" {
  for_each = local.databases

  metadata {
    name = "${replace(each.key, "_", "-")}-database"
  }

  data_wo = {
    username = module.database[each.key].app_user.username
    password = ephemeral.random_password.app[each.key].result
  }
  data_wo_revision = local.app_password_version
}

module "users" {
  for_each = local.users
  source   = "../..//modules/user"

  username = each.key
  roles    = each.value.roles
}
