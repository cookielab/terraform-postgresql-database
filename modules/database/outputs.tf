output "username" {
  value       = postgresql_role.owner.name
  description = "Owner role name"
}

output "password" {
  value       = local.password_write_only ? null : random_password.owner[0].result
  sensitive   = true
  description = "Owner role password, null when a write-only password is used"
}

output "database_name" {
  value       = postgresql_database.this.name
  description = "Database name"
}

output "schemas" {
  value       = { for schema in var.schemas : schema => schema == "public" ? schema : postgresql_schema.this[schema].name }
  description = "Map of schema names, values reference the created schemas so that grants depend on them"
}
