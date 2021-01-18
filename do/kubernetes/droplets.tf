data "digitalocean_sizes" "main" {
  sort {
    // Select cheapest size
    key       = "price_monthly"
    direction = "asc"
  }
}
