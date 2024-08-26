terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "4.4.0"
    }
  }
}

provider "aws" {
  region = var.region  # Ensure this variable is defined elsewhere
  alias  = "master-admin"
}

provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = var.master-vault-token
  alias   = "master-vault"
}
