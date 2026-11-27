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

variable "password_wo" {
  type        = string
  default     = null
  sensitive   = true
  ephemeral   = true
  description = "Write-only password of the role, used together with `password_wo_version`. It is not stored in state, the `password` output is null then."

  validation {
    condition     = var.password_wo == null || var.password_wo != ""
    error_message = "password_wo must not be empty."
  }
}

variable "password_wo_version" {
  type        = string
  default     = null
  description = "Version of the write-only role password. Setting it switches the role to `password_wo`; change it to write a new password. Null keeps the generated password stored in state."

  validation {
    condition     = (var.password_wo_version == null) == (var.password_wo == null)
    error_message = "Set both password_wo and password_wo_version, or neither."
  }
}
