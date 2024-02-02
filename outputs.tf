output "database_owner" {
  value     = module.database.database_owner
  sensitive = true
}

output "database_name" {
  value = module.database.database_name
}

output "connection_url" {
  value     = module.database.connection_url
  sensitive = true
}


output "username" {
  value = module.user.username
}

output "password" {
  value = module.user.password
}
