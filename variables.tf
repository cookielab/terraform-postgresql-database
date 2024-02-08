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
