output "owner_user" {
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

output "app_user" {
  value = {
    username = module.access_app.rolename
    password = module.access_app.password
  }
}

output "roles" {
  value = [
    module.access_ro.rolename,
    module.access_rw.rolename,
  ]
}
