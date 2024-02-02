resource "random_password" "this" {
  length           = 32
  special          = false
  override_special = "_%"
}

resource "postgresql_role" "this" {
  name     = var.username
  login    = true
  password = random_password.this.result

  lifecycle {
    ignore_changes = [
      roles,
    ]
  }
}

resource "postgresql_grant_role" "roles" {
  for_each   = toset(var.roles)
  role       = postgresql_role.this.name
  grant_role = each.key
}