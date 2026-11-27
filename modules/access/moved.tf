# Grants used to be created for the `public` schema only, without for_each.
moved {
  from = postgresql_grant.tables
  to   = postgresql_grant.tables["public"]
}

moved {
  from = postgresql_grant.schema
  to   = postgresql_grant.schema["public"]
}

moved {
  from = postgresql_grant.sequence
  to   = postgresql_grant.sequence["public"]
}

moved {
  from = postgresql_default_privileges.tables
  to   = postgresql_default_privileges.tables["public"]
}

moved {
  from = postgresql_default_privileges.sequences
  to   = postgresql_default_privileges.sequences["public"]
}
