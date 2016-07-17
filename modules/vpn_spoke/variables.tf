# variables

variable "vpc_id" {}

variable "bgp_asn" {}

variable "aws_customer_gateways" {}

variable "destination_cidr_block" {}

variable "public_route_table_id" {}

variable "private_route_tables" {}

variable "default_sg_id" {}

variable "availability_zones" {}

# tags

variable "project" {}

variable "environment" {}

variable "owner" {}

variable "email" {}
