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
