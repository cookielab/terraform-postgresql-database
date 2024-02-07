output "rolename" {
  value = var.allow_login ? postgresql_role.this[0].name : null
}

output "password" {
  value = var.allow_login ? postgresql_role.this[0].password : null
}
