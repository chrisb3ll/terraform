# main

resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name        = "${var.environment}_vpn_gw"
    Description = "${var.environment}_vpn_gw"
    project     = "${var.project}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
    email       = "${var.email}"
  }
}

resource "aws_customer_gateway" "hub" {
  count      = "${length(compact(split(",", var.aws_customer_gateways)))}"
  bgp_asn    = "${var.bgp_asn}"
  ip_address = "${element(split(",", var.aws_customer_gateways), count.index)}"
  type       = "ipsec.1"

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${var.environment}_customer_gw"
    Description = "${var.environment}_customer_gw"
    project     = "${var.project}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
    email       = "${var.email}"
  }
}

resource "aws_vpn_connection" "main" {
  count               = "${length(compact(split(",", var.aws_customer_gateways)))}"
  vpn_gateway_id      = "${aws_vpn_gateway.vpn_gateway.id}"
  customer_gateway_id = "${element(aws_customer_gateway.hub.*.id, count.index)}"
  type                = "ipsec.1"
  static_routes_only  = false

  tags {
    Name        = "${var.environment}_vpn"
    Description = "${var.environment}_vpn"
    project     = "${var.project}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
    email       = "${var.email}"
  }
}
