terraform {
  required_version = "> 0.12"
  backend "s3" {
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "https://fra1.digitaloceanspaces.com"
    region                      = "us-east-1" // needed
    bucket                      = "test-deploy"
    key                         = "infrastructure/terraform.tfstate"
  }
}

provider "digitalocean" {
  token = var.api_key

  spaces_access_id  = var.tf_space_id
  spaces_secret_key = var.tf_space_secret_key
}

resource "digitalocean_kubernetes_cluster" "sandbox" {
  name   = "sandbox"
  region = "fra1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.19.3-do.3"

  node_pool {
    name = "worker-pool"
    # we can setup only minimum with 2gb nodes
    size       = element(data.digitalocean_sizes.main.sizes, 1).slug
    node_count = 2
  }
}

provider "kubernetes" {
  load_config_file = false
  host             = digitalocean_kubernetes_cluster.sandbox.endpoint
  token            = digitalocean_kubernetes_cluster.sandbox.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.sandbox.kube_config[0].cluster_ca_certificate
  )
}
