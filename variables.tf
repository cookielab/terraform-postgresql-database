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
