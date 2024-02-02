output "database_owner" {
  value = {
    username = postgresql_role.owner_role.name
    password = random_password.db_password.result
  }
  sensitive = true
}

output "database_name" {
  value = postgresql_database.database.name
}

output "connection_url" {
  value     = "postgres://${postgresql_role.owner_role.name}:${random_password.db_password.result}@${var.database_private_hostname}/${postgresql_database.database.name}"
  sensitive = true
}
