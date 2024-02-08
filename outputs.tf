output "database_owner" {
  value = {
    username = module.database.username
    password = module.database.password
  }
  description = "Object returning database owners and their credentials"
}

output "database_name" {
  value       = module.database.database_name
  description = "Object returning database names"
}

output "access_user" {
  value = var.allow_login ? {
    username = module.access_app.rolename
    password = module.access_app.password
  } : null
}

output "roles" {
  value = [
    module.access_ro.rolename,
    module.access_rw.rolename,
  ]
}
