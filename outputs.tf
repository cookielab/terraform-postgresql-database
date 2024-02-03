#postgresql_role.owner_role.name
output "database_owner" {
  value = {
    username = { for db in keys(var.databases) : db => module.database[db].database_owner.username }
    password = { for db in keys(var.databases) : db => module.database[db].database_owner.password }
  }
  sensitive = true
}

output "database_name" {
  value = { for db in keys(var.databases) : db => module.database[db].database_name }
}

output "connection_url" {
  value     = { for db in keys(var.databases) : db => module.database[db].connection_url }
  sensitive = true
}

output "username" {
  value = { for user in keys(var.user_role) : user => module.user[user].username }
}

output "password" {
  value = { for user in keys(var.user_role) : user => module.user[user].password }
}
