output "rolename" {
  value       = var.create_role ? postgresql_role.this[0].name : null
  description = "Role name, null when the role is not created by this module"
}

output "password" {
  value       = var.allow_login && !local.password_write_only ? postgresql_role.this[0].password : null
  sensitive   = true
  description = "Role password, null when login is not allowed or a write-only password is used"
}
