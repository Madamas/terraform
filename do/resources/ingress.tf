resource "helm_release" "ingress-nginx" {
  name       = "nginx-ingress-controller"
  namespace  = "default"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.nginxDebug"
    value = true
  }

  # set {
  #   name  = "service.annotations.kubernetes\\.digitalocean\\.com/load-balancer-id"
  #   value = digitalocean_loadbalancer.ingress-load-balancer.id
  # }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/do-loadbalancer-vpc-id"
    value = data.digitalocean_vpc.default.id
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/do-loadbalancer-certificate-id"
    value = digitalocean_certificate.madamas-cyou-main.uuid
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/do-loadbalancer-protocol"
    value = "https"
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/do-loadbalancer-name"
    value = var.lb_name
  }

  depends_on = [
    digitalocean_certificate.madamas-cyou-main,
  ]
}

resource "kubernetes_ingress_class_v1" "sandbox-ingress" {
  metadata {
    name = "sandbox-ingress"
  }

  spec {
    controller = "k8s.io/ingress-nginx"
  }
}

resource "kubernetes_ingress_v1" "sandbox-ingress" {
  depends_on = [
    helm_release.ingress-nginx,
  ]

  # wait_for_load_balancer = true

  metadata {
    name = "sandbox-ingress"

    annotations = {
      # "kubernetes.io/ingress.class" : "k8s.io/ingress-nginx"
      "ingress.kubernetes.io/rewrite-target"  = "/"
      "nginx.ingress.kubernetes.io/use-regex" = true
    }
  }

  spec {
    ingress_class_name = kubernetes_ingress_class_v1.sandbox-ingress.metadata.0.name

    rule {
      host = var.domain_name

      http {
        path {
          path      = "/hello*"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service_v1.hello_world.metadata.0.name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "sandbox-ingress-dashboard" {
  depends_on = [
    helm_release.ingress-nginx,
  ]

  # wait_for_load_balancer = true

  metadata {
    name      = "sandbox-ingress"
    namespace = "kubernetes-dashboard"

    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/$2"
      "nginx.ingress.kubernetes.io/server-snippet" : <<EOF
        rewrite ^(/dashboard)$ $1/ redirect;
      EOF
      # "nginx.ingress.kubernetes.io/use-regex" : true
    }
  }

  spec {
    ingress_class_name = kubernetes_ingress_class_v1.sandbox-ingress.metadata.0.name

    rule {
      host = var.domain_name

      http {
        path {
          path = "/dashboard(/|$)(.*)"
          # path      = "/dashboard.*"
          # path_type = "Prefix"

          backend {
            service {
              name = "kubernetes-dashboard"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
