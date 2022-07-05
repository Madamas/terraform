resource "helm_release" "kubernetes-dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"

  namespace = "kubernetes-dashboard"

  values = [
    file("${path.cwd}/values/kubernetes_dashboard-values.yaml")
  ]
}
