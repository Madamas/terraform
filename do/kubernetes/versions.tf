terraform {
  # backend "local" {}

  # backend "pg" {
  #   conn_str = "postgres://postgres:postgrespw@localhost:49153?sslmode=disable"
  # }

  backend "s3" {
    endpoint                    = "fra1.digitaloceanspaces.com"
    key                         = "terraform.tfstate"
    region                      = "us-west-1"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}
