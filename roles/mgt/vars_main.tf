# vars main

# input with tf.sh
variable "environment" {}

# key
variable "key_name" {
  default = "terraform_key"
}

# az
variable "availability_zones" {
  default = "eu-west-1a,eu-west-1b,eu-west-1c"
}

# subnets
variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = "10.0.101.0/24,10.0.102.0/24,10.0.103.0/24"
}

variable "private_subnets" {
  default = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
}

# allowed IP addresses
variable "allowed_ips" {
  default = ""
}

# tags
variable "project" {
  default = "DefaultProject"
}

variable "owner" {
  default = "DefaultOwner"
}

variable "email" {
  default = "DefaultEmail@DefaultEmail.com"
}
