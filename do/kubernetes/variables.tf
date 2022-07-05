variable "api_key" {
  type = string
}

variable "tf_space_id" {
  type = string
}

variable "tf_space_secret_key" {
  type = string
}

variable "bucket" {
  type = string
}

variable "region" {
  type    = string
  default = "ams3"
}

variable "domain" {
  type    = string
  default = "madamas.tk"
}
