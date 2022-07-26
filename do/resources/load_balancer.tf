# resource "digitalocean_loadbalancer" "ingress-load-balancer" {
#   name      = "sandbox-lb"
#   region    = var.region
#   size      = "lb-small"
#   algorithm = "round_robin"

#   forwarding_rule {
#     entry_port     = 443
#     entry_protocol = "https"

#     target_port     = 80
#     target_protocol = "http"

#     certificate_name = digitalocean_certificate.madamas-cyou-main.name
#   }

#   # redirect_http_to_https = true

#   vpc_uuid = data.digitalocean_vpc.default.id

#   lifecycle {
#     ignore_changes = [
#       forwarding_rule,
#     ]
#   }
# }

data "digitalocean_vpc" "default" {
  name = "default"
}

resource "digitalocean_certificate" "madamas-cyou-main" {
  name              = "madamas-cyou-main"
  type              = "custom"
  private_key       = file("/home/madamas/repos/certs/base/privkey1.pem")
  leaf_certificate  = file("/home/madamas/repos/certs/base/cert1.pem")
  certificate_chain = file("/home/madamas/repos/certs/base/fullchain1.pem")
}
