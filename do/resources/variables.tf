variable "api_key" {
  type      = string
  sensitive = true
}

variable "secret_key" {
  type      = string
  sensitive = true
}

variable "tf_space_id" {
  type = string
}

variable "tf_space_secret_key" {
  type      = string
  sensitive = true
}

variable "bucket" {
  type = string
}

variable "region" {
  type    = string
  default = "ams3"
}

variable "atlas_public_key" {
  type = string
}

variable "atlas_private_key" {
  type      = string
  sensitive = true
}

variable "domain_name" {
  type = string
}

variable "lb_name" {
  type    = string
  default = "sandbox-lb"
}
