resource "digitalocean_loadbalancer" "ingress-load-balancer" {
  name      = "sandbox-lb"
  region    = var.region
  size      = "lb-small"
  algorithm = "round_robin"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"

  }

  lifecycle {
    ignore_changes = [
      forwarding_rule,
    ]
  }
}

# data "digitalocean_loadbalancer" "ingress-load-balancer" {
#   name = "sandbox-lb"
# }
