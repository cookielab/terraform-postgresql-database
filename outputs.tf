output "database_owner" {
  value = {
    username = { for db in keys(var.databases) : db => module.database[db].database_owner.username }
    password = { for db in keys(var.databases) : db => module.database[db].database_owner.password }
  }
  sensitive   = true
  description = "Object returning database owners and their credentials"
}

output "database_name" {
  value       = { for db in keys(var.databases) : db => module.database[db].database_name }
  description = "Object returning database names"
}

output "username" {
  value       = { for user in keys(var.user_role) : user => module.user[user].username }
  description = "Object returning usersnames"
}

output "password" {
  value       = { for user in keys(var.user_role) : user => module.user[user].password }
  description = "Object returning usersnames and their passwords"
}
