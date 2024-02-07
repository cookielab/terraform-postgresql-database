output "database_owner" {
  value = {
    username = postgresql_role.owner.name
    password = random_password.owner.result
  }
  sensitive = true
}

output "database_name" {
  value = postgresql_database.this.name
}
