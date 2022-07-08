resource "kubernetes_namespace_v1" "kubernetes_dashboard" {
  metadata {
    annotations = {
      name = "dasboard"
    }

    name = "kubernetes-dashboard"
  }
}
