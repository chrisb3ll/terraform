# nat

resource "aws_eip" "nat_gw" {
  count = "${length(split(",", var.availability_zones))}"
  vpc   = true
}

resource "aws_nat_gateway" "gw" {
  count         = "${length(split(",", var.availability_zones))}"
  allocation_id = "${element(aws_eip.nat_gw.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.default"]
}

resource "aws_route" "internet_access" {
  count                  = "${length(split(",", var.availability_zones))}"
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.gw.*.id, count.index)}"
}
