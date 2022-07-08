# resource "kubernetes_service_account_v1" "dashboard-user" {
#   metadata {
#     name      = "dashboard-user"
#     namespace = "kubernetes-dashboard"
#   }
# }

# resource "kubernetes_cluster_role_binding_v1" "dashobard-user" {
#   metadata {
#     name = "dashboard-user"
#   }

#   subject {
#     kind = "ServiceAccount"
#     name = "default"
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "cluster-admin"
#   }
#   subject {
#     kind      = "User"
#     name      = "admin"
#     api_group = "rbac.authorization.k8s.io"
#   }
#   subject {
#     kind      = "ServiceAccount"
#     name      = "default"
#     namespace = "kubernetes-dashobard"
#   }
#   subject {
#     kind      = "Group"
#     name      = "system:masters"
#     api_group = "rbac.authorization.k8s.io"
#   }
# }
