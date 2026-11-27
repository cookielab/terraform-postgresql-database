# Calls the root module as a child module, the way consumers use it (the root
# module's outputs carry sensitive values and cannot be root outputs as-is).
module "this" {
  source = "../../.."

  database                  = var.database
  schemas                   = var.schemas
  owner_password_wo         = var.owner_password_wo
  owner_password_wo_version = var.owner_password_wo_version
  app_password_wo           = var.app_password_wo
  app_password_wo_version   = var.app_password_wo_version
}

variable "database" {
  type = string
}

variable "schemas" {
  type    = list(string)
  default = ["public"]
}

variable "owner_password_wo" {
  type      = string
  default   = null
  sensitive = true
  ephemeral = true
}

variable "owner_password_wo_version" {
  type    = string
  default = null
}

variable "app_password_wo" {
  type      = string
  default   = null
  sensitive = true
  ephemeral = true
}

variable "app_password_wo_version" {
  type    = string
  default = null
}

output "database_name" {
  value = module.this.database_name
}

output "roles" {
  value = module.this.roles
}

output "owner_user" {
  value     = module.this.owner_user
  sensitive = true
}

output "app_user" {
  value     = module.this.app_user
  sensitive = true
}
