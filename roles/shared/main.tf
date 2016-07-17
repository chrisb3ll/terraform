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
