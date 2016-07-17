# routes

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name        = "${var.environment}_public"
    Description = "${var.environment}_public"
    project     = "${var.project}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
    email       = "${var.email}"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

resource "aws_route_table" "private" {
  count  = "${length(split(",", var.availability_zones))}"
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name        = "${var.environment}_private_${count.index + 1}"
    Description = "${var.environment}_private_${count.index + 1}"
    project     = "${var.project}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
    email       = "${var.email}"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(compact(split(",", var.public_subnets)))}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(compact(split(",", var.private_subnets)))}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}
