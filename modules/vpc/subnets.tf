# subnets

resource "aws_subnet" "public" {
  count                   = "${length(compact(split(",", var.public_subnets)))}"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${element(split(",", var.public_subnets), count.index)}"
  availability_zone       = "${element(split(",", var.availability_zones), count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "${var.environment}_public_${count.index + 1}"
    Description = "${var.environment}_public_${count.index + 1}"
    project     = "${var.project}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
    email       = "${var.email}"
  }
}

resource "aws_subnet" "private" {
  count             = "${length(compact(split(",", var.private_subnets)))}"
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${element(split(",", var.private_subnets), count.index)}"
  availability_zone = "${element(split(",", var.availability_zones), count.index)}"

  tags {
    Name        = "${var.environment}_private_${count.index + 1}"
    Description = "${var.environment}_private_${count.index + 1}"
    project     = "${var.project}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
    email       = "${var.email}"
  }
}
