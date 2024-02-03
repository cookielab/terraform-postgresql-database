variable "databases" {
  type = map(object({
    database = string
  }))
  description = "databases object"
}

variable "create_access_user" {
  type        = bool
  description = "create access user"
  default     = false
}

variable "database_private_hostname" {
  type = string
}

variable "user_role" {
  type = map(object({
    roles = list(string)
  }))
}
