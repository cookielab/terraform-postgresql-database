variable "databases" {
  type = map(object({
    database = string
    owner    = optional(string, null)
    roles    = list(string)
  }))
  description = "databases object: { ACCESS_USER = { database = \"DBNAME\" roles = [ \"ROLE1\"] } … }"
}

variable "create_role" {
  type        = bool
  default     = false
  description = "Create role"
}

variable "user_role" {
  type = map(object({
    roles = list(string)
  }))
  description = "users object: { \"USERNAME\" = { \"roles\" = [ \"ROLE1\", … ] } … }"
}
