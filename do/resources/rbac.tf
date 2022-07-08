resource "kubernetes_cluster_role_binding_v1" "dashboard-user" {
  depends_on = [
    kubernetes_cluster_role_binding_v1.dashboard-user
  ]

  metadata {
    name = "dashboard-user"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "dashboard-user"
  }
  subject {
    kind      = "User"
    name      = "dashboard-user"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "dashboard-user"
    namespace = "kubernetes-dashboard"
  }
}

resource "kubernetes_cluster_role_v1" "dashboard-user" {
  metadata {
    name = "dashboard-user"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "deployments", "namespaces"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "list", "watch", "update"]
  }
}

resource "kubernetes_service_account_v1" "dashboard-user" {
  metadata {
    name      = "dashboard-user"
    namespace = "kubernetes-dashboard"
    annotations = {
      "app.kubernetes.io/managed-by" : "Helm"
      "meta.helm.sh/release-name" : "kubernetes-dashboard"
      "meta.helm.sh/release-namespace" : "kubernetes-dashboard"
    }
    labels = {
      "app.kubernetes.io/managed-by" : "Helm"
      "meta.helm.sh/release-name" : "kubernetes-dashboard"
      "meta.helm.sh/release-namespace" : "kubernetes-dashboard"
    }
  }

  automount_service_account_token = true
}
