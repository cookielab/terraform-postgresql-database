variable "username" {
  type        = string
  description = "user name"
}

variable "roles" {
  type        = list(string)
  description = "user roles"
}