variable "database_name" {
  type        = string
  description = "database name"
}

variable "database_owner" {
  type        = string
  description = "database owner"
}

variable "create_role" {
  type        = bool
  description = "create role"
  default     = false
}

variable "role_name" {
  type        = string
  description = "grantee user"
}

variable "allow_login" {
  type = bool
}

variable "access_map" {
  type = object({
    table_rights    = list(string)
    sequence_rights = list(string)
    schema_rights   = list(string)
    database_rights = list(string)
    }
  )
}

variable "schemas" {
  type        = map(string)
  default     = { public = "public" }
  description = "Schemas to grant access to, map of key => schema name. Pass references to the schema resources (e.g. the `schemas` output of the database module) so the grants wait for the schemas."

  validation {
    condition     = length(var.schemas) > 0
    error_message = "schemas must contain at least one schema."
  }
}
