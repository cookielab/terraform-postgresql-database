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
