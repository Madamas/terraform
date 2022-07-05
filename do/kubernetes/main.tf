# data "digitalocean_kubernetes_cluster" "cluster" {
#   name = "sandbox"
# }

provider "digitalocean" {
  token = var.api_key

  spaces_access_id  = var.tf_space_id
  spaces_secret_key = var.tf_space_secret_key
}

provider "kubernetes" {
  host  = data.digitalocean_kubernetes_cluster.sandbox.endpoint
  token = data.digitalocean_kubernetes_cluster.sandbox.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.sandbox.kube_config[0].cluster_ca_certificate
  )
}

resource "digitalocean_kubernetes_cluster" "sandbox" {
  name   = "sandbox"
  region = var.region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.21.14-do.0"

  node_pool {
    name       = "worker-pool"
    size       = element(data.digitalocean_sizes.main.sizes, 1).slug
    node_count = 1
  }
}
