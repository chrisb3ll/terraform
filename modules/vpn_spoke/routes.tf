# routes

resource "aws_route" "corp_dc_pub" {
  route_table_id         = "${var.public_route_table_id}"
  destination_cidr_block = "${var.destination_cidr_block}"
  gateway_id             = "${aws_vpn_gateway.vpn_gateway.id}"
}

resource "aws_route" "corp_dc_priv" {
  count                  = "${length(split(",", var.availability_zones))}"
  route_table_id         = "${element(split(",", var.private_route_tables), count.index)}"
  destination_cidr_block = "${var.destination_cidr_block}"
  gateway_id             = "${aws_vpn_gateway.vpn_gateway.id}"
}
