output "username" {
  value = postgresql_role.this.name
}

output "password" {
  value = random_password.this.result
}