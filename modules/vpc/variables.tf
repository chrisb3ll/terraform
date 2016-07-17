# variables

variable "availability_zones" {}

variable "cidr_block" {}

variable "public_subnets" {
  default = ""
}

variable "private_subnets" {
  default = ""
}

variable "allowed_ips" {}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_dns_support" {
  default = true
}

# tags

variable "project" {}

variable "environment" {}

variable "owner" {}

variable "email" {}
