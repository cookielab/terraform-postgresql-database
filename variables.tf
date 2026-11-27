variable "database" {
  type        = string
  description = "Database name"
}

variable "owner_username" {
  default     = null
  type        = string
  description = "Database owner"
}

variable "app_username" {
  default     = null
  type        = string
  description = "Application username"
}

variable "role_ro_name" {
  default     = null
  type        = string
  description = "Read-only role name"
}

variable "role_rw_name" {
  default     = null
  type        = string
  description = "Read-write role name"
}

variable "create_role_ro" {
  default     = true
  type        = bool
  description = "Toggle read-only role creation"
}

variable "create_role_rw" {
  default     = true
  type        = bool
  description = "Toggle read-write role creation"
}

variable "template" {
  default     = "template0"
  type        = string
  description = "Template database the database is created from. Changing it replaces the database."
}

variable "encoding" {
  default     = "UTF8"
  type        = string
  description = "Character set encoding of the database. Changing it replaces the database."
}

variable "lc_collate" {
  default     = "en_US.UTF-8"
  type        = string
  description = "Collation order (LC_COLLATE) of the database. Changing it replaces the database."
}

variable "lc_ctype" {
  default     = "en_US.UTF-8"
  type        = string
  description = "Character classification (LC_CTYPE) of the database. Changing it replaces the database."
}

variable "schemas" {
  default     = ["public"]
  type        = list(string)
  description = "Schemas the roles get access to (grants on existing tables and sequences plus default privileges for objects created by the owner). Every schema except `public` is created and owned by the database owner."

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

variable "owner_password_wo" {
  default     = null
  type        = string
  sensitive   = true
  ephemeral   = true
  description = "Write-only password of the database owner, used together with `owner_password_wo_version`. It is not stored in state and `owner_user.password` is null then. Requires Terraform >= 1.11."

  validation {
    condition     = var.owner_password_wo == null || var.owner_password_wo != ""
    error_message = "owner_password_wo must not be empty."
  }
}

variable "owner_password_wo_version" {
  default     = null
  type        = string
  description = "Version of the write-only owner password. Setting it switches the owner to `owner_password_wo`; change it to write a new password. Null keeps the generated password stored in state."

  validation {
    condition     = (var.owner_password_wo_version == null) == (var.owner_password_wo == null)
    error_message = "Set both owner_password_wo and owner_password_wo_version, or neither."
  }
}

variable "app_password_wo" {
  default     = null
  type        = string
  sensitive   = true
  ephemeral   = true
  description = "Write-only password of the application user, used together with `app_password_wo_version`. It is not stored in state and `app_user.password` is null then. Requires Terraform >= 1.11."

  validation {
    condition     = var.app_password_wo == null || var.app_password_wo != ""
    error_message = "app_password_wo must not be empty."
  }
}

variable "app_password_wo_version" {
  default     = null
  type        = string
  description = "Version of the write-only application user password. Setting it switches the user to `app_password_wo`; change it to write a new password. Null keeps the generated password stored in state."

  validation {
    condition     = (var.app_password_wo_version == null) == (var.app_password_wo == null)
    error_message = "Set both app_password_wo and app_password_wo_version, or neither."
  }
}
