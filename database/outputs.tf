output "username" {
  value = postgresql_role.owner.name
}

output "password" {
  value     = random_password.owner.result
  sensitive = true
}

output "database_name" {
  value = postgresql_database.this.name
}
