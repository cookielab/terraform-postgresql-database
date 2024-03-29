output "owner_user" {
  value = {
    username = module.database.username
    password = module.database.password
  }
  description = "Object returning database owner and its credentials"
}

output "database_name" {
  value       = module.database.database_name
  description = "Object returning database names"
}

output "app_user" {
  value = {
    username = module.access_app.rolename
    password = module.access_app.password
  }
  description = "Object returning application user and its credentials"
}

output "roles" {
  value = [
    module.access_ro.rolename,
    module.access_rw.rolename,
  ]
  description = "List of additional roles having permission on the database"
}
