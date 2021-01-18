resource "digitalocean_domain" "default" {
  name = var.domain
}

resource "digitalocean_record" "www" {
  domain = digitalocean_domain.default.name
  type   = "A"
  name   = "@"
  value  = ""
}
