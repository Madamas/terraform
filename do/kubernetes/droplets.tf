data "digitalocean_sizes" "main" {
  filter {
    key    = "vcpus"
    values = [1, 2]
  }

  filter {
    key    = "memory"
    values = [2048, 4096]
  }

  filter {
    key    = "regions"
    values = ["ams3"]
  }

  sort {
    // Select cheapest size
    key       = "price_monthly"
    direction = "asc"
  }
}
