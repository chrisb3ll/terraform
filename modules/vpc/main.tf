# main

resource "aws_vpc" "default" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name        = "${var.environment}_vpc"
    Description = "${var.environment}_vpc"
    project     = "${var.project}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
    email       = "${var.email}"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name        = "${var.environment}_igw"
    Description = "${var.environment}_igw"
    project     = "${var.project}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
    email       = "${var.email}"
  }
}
