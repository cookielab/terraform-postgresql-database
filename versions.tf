terraform {
  required_version = ">= 1.11.0, < 2.0.0"
  required_providers {
    # tflint-ignore: terraform_unused_required_providers
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.26"
    }
  }
}
