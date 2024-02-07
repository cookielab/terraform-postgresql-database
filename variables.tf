variable "databases" {
  type = map(object({
    database = string
    roles    = list(string)
  }))
  description = "databases object: { ACCESS_USER = { database = \"DBNAME\" roles = [ \"ROLE1\"] } … }"
}

variable "create_access_user" {
  type        = bool
  default     = false
  description = "Create access user"
}

variable "user_role" {
  type = map(object({
    roles = list(string)
  }))
  description = "users object: { \"USERNAME\" = { \"roles\" = [ \"ROLE1\", … ] } … }"
}
