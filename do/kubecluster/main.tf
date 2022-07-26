provider "digitalocean" {
  token = var.api_key

  spaces_access_id  = var.tf_space_id
  spaces_secret_key = var.tf_space_secret_key
}

resource "digitalocean_kubernetes_cluster" "sandbox" {
  name   = "sandbox"
  region = var.region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.23.9-do.0"

  vpc_uuid = data.digitalocean_vpc.default.id
  node_pool {
    name       = "worker-pool"
    size       = element(data.digitalocean_sizes.main.sizes, 1).slug
    node_count = 1
  }
}

data "digitalocean_vpc" "default" {
  name = "default"
}

resource "digitalocean_kubernetes_node_pool" "autoscale-pool-01" {
  cluster_id = digitalocean_kubernetes_cluster.sandbox.id
  name       = "autoscale-pool-01"
  size       = "s-1vcpu-2gb"
  auto_scale = true
  min_nodes  = 1
  max_nodes  = 5
}
