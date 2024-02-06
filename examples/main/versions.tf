terraform {
  required_version = ">= 1.2, < 2.0"

  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.21.0"
    }
  }
}
