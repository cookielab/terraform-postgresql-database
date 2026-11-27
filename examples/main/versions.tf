terraform {
  required_version = ">= 1.11, < 2.0"

  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.27.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.36.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.0"
    }
  }
}
