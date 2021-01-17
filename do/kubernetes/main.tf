provider "digitalocean" {
    token = var.api_key
}

resource "digitalocean_kubernetes_cluster" "sandbox" {
  name   = "sandbox"
  region = "fra1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.19.3-do.3"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
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