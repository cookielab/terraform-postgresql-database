#Soucasti tohoto modulu by byly sumboduly database , access (puvodni dbaccess) a user (puvodni dbuser)

#S tim ze access modul by mel navic variable ktera bude u role ridit login = true/false (diky tomu budeme moc pomoci teto role resit i applikacniho usera).
#Take bych pridal access-ro sub-modul ktery bude pouze wrapper nad access s naplnenou access_map pro RO access to same pro access-rw .

#Cele to samozrejme bude obalovat root modul ktery zalozi DB a uzivatele (migrator - owner), app uzivatele a role (non-login) pro developer (FOO-user-ro) a super_developer (FOO-user-rw).

#S tim ze vsechny role budou prefixovane nazvem db. Tj napr jdl-stage-migrator jdl-dev-app  atd... + Zmenil bych namin developer a super_developer na user-ro a user-rw resp jdl-stage-user-ro...
#Nad tohle budeme celkem dobre schopni "nabalit" projekt specific věci.

locals {
  database_readonly_rights = {
    table_rights    = ["SELECT"]
    sequence_rights = ["USAGE"]
    schema_rights   = ["USAGE"]
    database_rights = ["CONNECT"]
  }
  database_readwrite_rights = {
    table_rights    = ["SELECT", "UPDATE", "INSERT", "DELETE", "TRIGGER", "REFERENCES", "TRUNCATE"]
    sequence_rights = ["SELECT", "UPDATE"]
    schema_rights   = ["USAGE"],
    database_rights = ["CONNECT"],
  }
}

module "database" {
  for_each = var.databases

  source = "./database"

  owner_username = each.value.owner
  database_name  = each.value.database
}

module "access_rw" {
  for_each = var.databases

  source = "./access"

  database_name  = each.value.database
  database_owner = module.database[each.key].database_owner.username
  create_role    = var.create_role
  role_name      = "${each.value.database}_rw"
  allow_login    = try(each.value.allow_login, true)
  access_map     = local.database_readwrite_rights
  depends_on     = [module.database]
}

module "access_ro" {
  for_each = var.databases

  source = "./access"

  database_name  = each.value.database
  database_owner = module.database[each.key].database_owner.username
  create_role    = var.create_role
  role_name      = "${each.value.database}_ro"
  allow_login    = try(each.value.allow_login, true)
  access_map     = local.database_readonly_rights
  depends_on     = [module.database]
}

module "user" {
  for_each = var.user_role

  source = "./user"

  username = each.key
  roles    = each.value.roles
  depends_on = [
    module.access_rw,
    module.access_ro,
  ]
}
