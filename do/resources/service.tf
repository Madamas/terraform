# resource "kubernetes_service" "kubernetes-dashboard" {
#   metadata {
#     name = "blog-backend-service"
#     labels = {
#       app = "blog-backend"
#     }
#   }
#   spec {
#     type = "ClusterIP"

#     selector = {
#       app = "blog-backend"
#     }

#     port {
#       port        = 8080
#       target_port = 8080
#     }
#   }
# }
