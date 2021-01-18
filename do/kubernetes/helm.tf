# setup account for tiller
# add role binding
# and initiate helm provider
resource "kubernetes_service_account" "tiller" {
  automount_service_account_token = true

  metadata {
    name      = "tiller-service-account"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "tiller-cluster-rule"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.tiller.metadata.0.name
    api_group = ""
    namespace = kubernetes_service_account.tiller.metadata.0.namespace
  }
}

provider "helm" {
  install_tiller  = true
  service_account = kubernetes_service_account.tiller.metadata.0.name
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.11.0"

  kubernetes {
    host                   = digitalocean_kubernetes_cluster.sandbox.endpoint
    client_certificate     = base64decode(digitalocean_kubernetes_cluster.sandbox.kube_config.0.client_certificate)
    client_key             = base64decode(digitalocean_kubernetes_cluster.sandbox.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.sandbox.kube_config.0.cluster_ca_certificate)
  }
}

resource "helm_release" "traefik" {
  repository = "https://helm.traefik.io/traefik"
  version    = "v9.12.3"
}
