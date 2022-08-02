resource "kubernetes_secret_v1" "tls" {
  metadata {
    name      = "main-tls"
    namespace = "default"
  }

  type = "kubernetes.io/tls"


  data = {
    "tls.crt" = file("/home/madamas/repos/certs/base/cert1.pem")
    "tls.key" = file("/home/madamas/repos/certs/base/privkey1.pem")
  }
}


resource "kubernetes_secret_v1" "tls-dashboard" {
  metadata {
    name      = "main-tls"
    namespace = "kubernetes-dashboard"
  }

  type = "kubernetes.io/tls"


  data = {
    "tls.crt" = file("/home/madamas/repos/certs/base/cert1.pem")
    "tls.key" = file("/home/madamas/repos/certs/base/privkey1.pem")
  }

  depends_on = [
    helm_release.kubernetes-dashboard
  ]
}
