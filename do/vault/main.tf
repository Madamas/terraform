provider "digitalocean" {
  token = var.api_key

  spaces_access_id  = var.tf_space_id
  spaces_secret_key = var.tf_space_secret_key
}

resource "digitalocean_domain" "default" {
  name = var.domain_name
}

resource "digitalocean_record" "vault" {
  domain = digitalocean_domain.default.id
  type   = "A"
  name   = "vault"
  ttl    = 3600
  value  = digitalocean_droplet.vault.ipv4_address
}

resource "digitalocean_ssh_key" "default" {
  name       = "l13 yoga fedora"
  public_key = file("/home/madamas/.ssh/id_ed25519.pub")
}

resource "digitalocean_certificate" "madamas-cyou" {
  name              = "madamas-cyou"
  type              = "custom"
  private_key       = file("/home/madamas/repos/certs/wildcard/privkey2.pem")
  leaf_certificate  = file("/home/madamas/repos/certs/wildcard/cert2.pem")
  certificate_chain = file("/home/madamas/repos/certs/wildcard/fullchain2.pem")
}

resource "digitalocean_droplet" "vault" {
  image  = "ubuntu-22-04-x64"
  name   = "vault"
  region = var.region
  size   = "s-1vcpu-1gb-intel"

  vpc_uuid = digitalocean_vpc.default.id
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}

resource "digitalocean_vpc" "default" {
  name   = "default"
  region = var.region
}
