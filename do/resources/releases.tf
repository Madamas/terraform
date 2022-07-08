resource "helm_release" "kubernetes-dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"

  namespace = "kubernetes-dashboard"

  values = [
    file("${path.cwd}/values/kubernetes_dashboard-values.yaml")
  ]
}

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
