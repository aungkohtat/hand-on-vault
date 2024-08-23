terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.4.0"
    }
  }
}

provider "vault" {
  address = "http://0.0.0.0:8200"
  alias   = "vrd1" 
}
