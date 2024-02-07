output "database_owner" {
  value = {
    username = postgresql_role.owner.name
    password = random_password.owner.result
  }
  sensitive = true
}

output "database_name" {
  value = postgresql_database.database.name
}

output "connection_url" {
  value     = "postgres://${postgresql_role.owner.name}:${random_password.owner.result}@${var.database_private_hostname}/${postgresql_database.database.name}"
  sensitive = true
}
