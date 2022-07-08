data "digitalocean_kubernetes_cluster" "sandbox" {
  name = "sandbox"
}

provider "digitalocean" {
  token = var.api_key

  spaces_access_id  = var.tf_space_id
  spaces_secret_key = var.tf_space_secret_key
}

provider "helm" {
  kubernetes {
    host  = data.digitalocean_kubernetes_cluster.sandbox.endpoint
    token = data.digitalocean_kubernetes_cluster.sandbox.kube_config[0].token
    cluster_ca_certificate = base64decode(
      data.digitalocean_kubernetes_cluster.sandbox.kube_config[0].cluster_ca_certificate
    )
  }
}

provider "kubernetes" {
  host  = data.digitalocean_kubernetes_cluster.sandbox.endpoint
  token = data.digitalocean_kubernetes_cluster.sandbox.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.sandbox.kube_config[0].cluster_ca_certificate
  )
}
