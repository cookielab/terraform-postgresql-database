# Calls the root module as a child module, the way consumers use it (the root
# module's outputs carry sensitive values and cannot be root outputs as-is).
module "this" {
  source = "../../.."

  database = var.database
  schemas  = var.schemas
}

variable "database" {
  type = string
}

variable "schemas" {
  type    = list(string)
  default = ["public"]
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
