output "rolename" {
  value = postgresql_role.this[0].name
}

output "password" {
  value = var.allow_login ? postgresql_role.this[0].password : null
}
