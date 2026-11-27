variable "database_name" {
  type        = string
  description = "Database name"
}

variable "owner_username" {
  type        = string
  default     = null
  description = "Database owner role name, defaults to `<database_name>_migrator`"
}

variable "template" {
  type        = string
  default     = "template0"
  description = "Template database the database is created from. Changing it replaces the database."
}

variable "encoding" {
  type        = string
  default     = "UTF8"
  description = "Character set encoding of the database. Changing it replaces the database."
}

variable "lc_collate" {
  type        = string
  default     = "en_US.UTF-8"
  description = "Collation order (LC_COLLATE) of the database. Changing it replaces the database."
}

variable "lc_ctype" {
  type        = string
  default     = "en_US.UTF-8"
  description = "Character classification (LC_CTYPE) of the database. Changing it replaces the database."
}

variable "schemas" {
  type        = list(string)
  default     = ["public"]
  description = "Schemas of the database. Every schema except `public` (which exists in every database) is created and owned by the owner role."

  validation {
    condition     = length(var.schemas) > 0
    error_message = "schemas must contain at least one schema."
  }

  validation {
    condition     = alltrue([for schema in var.schemas : try(trimspace(schema), "") != ""])
    error_message = "schemas must not contain empty names."
  }

  validation {
    condition     = length(var.schemas) == length(distinct(var.schemas))
    error_message = "schemas must not contain duplicates."
  }
}

variable "password_wo" {
  type        = string
  default     = null
  sensitive   = true
  ephemeral   = true
  description = "Write-only owner password, used together with `password_wo_version`. It is not stored in state, the `password` output is null then."

  validation {
    condition     = var.password_wo == null || var.password_wo != ""
    error_message = "password_wo must not be empty."
  }
}

variable "password_wo_version" {
  type        = string
  default     = null
  description = "Version of the write-only owner password. Setting it switches the owner role to `password_wo`; change it to write a new password. Null keeps the generated password stored in state."

  validation {
    condition     = (var.password_wo_version == null) == (var.password_wo == null)
    error_message = "Set both password_wo and password_wo_version, or neither."
  }
}
