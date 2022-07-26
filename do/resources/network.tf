data "digitalocean_domain" "default" {
  name = var.domain_name
}

data "digitalocean_loadbalancer" "ingress-load-balancer" {
  name = var.lb_name

  depends_on = [
    helm_release.ingress-nginx
  ]
}

resource "digitalocean_record" "loadbalancer" {
  domain = data.digitalocean_domain.default.id
  type   = "A"
  name   = "@"
  ttl    = 3600
  value  = data.digitalocean_loadbalancer.ingress-load-balancer.ip
}
