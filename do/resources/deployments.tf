resource "kubernetes_deployment_v1" "hello_world" {
  metadata {
    name = "hello-world-app"
    labels = {
      app = "hello-world-app"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "hello-world-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello-world-app"
        }
      }

      spec {
        container {
          image = "gcr.io/google-samples/node-hello:1.0"
          name  = "hello-world"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}
