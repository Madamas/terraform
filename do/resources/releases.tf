resource "helm_release" "kubernetes-dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"

  namespace = "kubernetes-dashboard"

  values = [
    file("${path.cwd}/values/kubernetes_dashboard-values.yaml")
  ]

  depends_on = [
    kubernetes_namespace_v1.kubernetes_dashboard
  ]
}

resource "helm_release" "hashicorp-vault" {
  name       = "hashicorp-vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"

  namespace = "vault"

  set {
    name  = "server.ingress.ingressClassName"
    value = kubernetes_ingress_class_v1.sandbox-ingress.metadata.0.name
  }

  values = [
    file("${path.cwd}/values/hashicorp_vault-values.yaml")
  ]

  depends_on = [
    kubernetes_namespace_v1.vault
  ]
}
