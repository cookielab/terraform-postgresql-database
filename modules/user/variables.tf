variable "username" {
  type        = string
  description = "user name"
}

variable "roles" {
  type        = list(string)
  description = "user roles"
}

variable "password_wo" {
  type        = string
  default     = null
  sensitive   = true
  ephemeral   = true
  description = "Write-only password of the user, used together with `password_wo_version`. It is not stored in state, the `password` output is null then."

  validation {
    condition     = var.password_wo == null || var.password_wo != ""
    error_message = "password_wo must not be empty."
  }
}

variable "password_wo_version" {
  type        = string
  default     = null
  description = "Version of the write-only user password. Setting it switches the role to `password_wo`; change it to write a new password. Null keeps the generated password stored in state."

  validation {
    condition     = (var.password_wo_version == null) == (var.password_wo == null)
    error_message = "Set both password_wo and password_wo_version, or neither."
  }
}
