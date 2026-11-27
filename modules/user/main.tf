locals {
  password_write_only = var.password_wo_version != null
}

resource "random_password" "this" {
  count = local.password_write_only ? 0 : 1

  length           = 32
  special          = false
  override_special = "_%"
}

resource "postgresql_role" "this" {
  name                = var.username
  login               = true
  password            = local.password_write_only ? null : random_password.this[0].result
  password_wo         = local.password_write_only ? var.password_wo : null
  password_wo_version = var.password_wo_version

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
