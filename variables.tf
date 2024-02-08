#variable "databases" {
#  type = map(object({
#    database    = string
#    owner       = optional(string, null)
#    allow_login = optional(bool, true)
#    roles       = list(string)
#  }))
#  description = "databases object: { ACCESS_USER = { database = \"DBNAME\" roles = [ \"ROLE1\"] } … }"
#}
#
#variable "user_role" {
#  type = map(object({
#    roles = list(string)
#  }))
#  description = "users object: { \"USERNAME\" = { \"roles\" = [ \"ROLE1\", … ] } … }"
#}

variable "create_role" {
  type        = bool
  default     = false
  description = "Create role"
}

variable "database" {
  type        = string
  description = "Database name"
}

variable "owner" {
  default     = null
  type        = string
  description = "Database owner"
}

variable "allow_login" {
  default     = true
  type        = bool
  description = "Allow login for roles"
}
