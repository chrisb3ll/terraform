# main

module "vpc" {
  source             = "../../modules/vpc"
  availability_zones = "${var.availability_zones}"
  cidr_block         = "${var.cidr_block}"
  private_subnets    = "${var.private_subnets}"
  public_subnets     = "${var.public_subnets}"
  allowed_ips        = "${var.allowed_ips}"

  project     = "${var.project}"
  environment = "${var.environment}"
  owner       = "${var.owner}"
  email       = "${var.email}"
}

module "vpn_spoke" {
  source                 = "../../modules/vpn_spoke"
  vpc_id                 = "${module.vpc.vpc_id}"
  bgp_asn                = "${var.bgp_asn}"
  aws_customer_gateways  = "${var.aws_customer_gateways}"
  destination_cidr_block = "${var.destination_cidr_block}"
  private_route_tables   = "${module.vpc.private_route_tables}"
  public_route_table_id  = "${module.vpc.public_route_table_id}"
  default_sg_id          = "${module.vpc.default_sg_id}"
  availability_zones     = "${var.availability_zones}"

  project     = "${var.project}"
  environment = "${var.environment}"
  owner       = "${var.owner}"
  email       = "${var.email}"
}
