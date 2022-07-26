terraform {
  backend "s3" {
    endpoint                    = "fra1.digitaloceanspaces.com"
    key                         = "terraform-atlas.tfstate"
    region                      = "us-west-1"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }

  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.0"
    }
  }
}
