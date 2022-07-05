provider "helm" {
  kubernetes {
    host  = data.digitalocean_kubernetes_cluster.sandbox.endpoint
    token = data.digitalocean_kubernetes_cluster.sandbox.kube_config[0].token
    cluster_ca_certificate = base64decode(
      data.digitalocean_kubernetes_cluster.sandbox.kube_config[0].cluster_ca_certificate
    )
  }
}
