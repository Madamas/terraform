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

resource "kubernetes_service_v1" "hello_world" {
  metadata {
    name = "hello-world"
  }

  spec {
    selector         = kubernetes_deployment_v1.hello_world.metadata.0.labels
    session_affinity = "ClientIP"

    port {
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}
