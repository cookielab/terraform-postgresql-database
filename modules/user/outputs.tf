output "username" {
  value       = postgresql_role.this.name
  description = "User name"
}

output "password" {
  value       = local.password_write_only ? null : random_password.this[0].result
  sensitive   = true
  description = "User password, null when a write-only password is used"
}
