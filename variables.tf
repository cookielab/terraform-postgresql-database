# >>> ACCESS
variable "databases" {
  type        = map(object({
    database = string
  }))
  description = "databases object"
}

#variable "database_owner" {
#  type        = string
#  description = "database owner"
#}

variable "create_access_user" {
  type        = bool
  description = "create access user"
  default     = false
}
variable "access_user" {
  type        = map(object({
    database = string
  }))
  description = "grantee user"
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
# <<< ACCESS

# >>> DATABASE
#variable "database_name" { # already defined in access
#  type = string
#}

variable "database_private_hostname" {
  type = string
}
# <<< DATABASE

# >>> USER
variable "user_role" {
  type = map(object({
    roles = list(string)
  }))
}
#variable "username" {
#  type        = string
#  description = "user name"
#}

variable "roles" {
  type        = map(object({
    roles = list(string)
  }))
  description = "user roles"
}
# <<< USER
