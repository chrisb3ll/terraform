# default sg

resource "aws_security_group" "default_sg" {
  name        = "${var.environment}_default_sg"
  description = "${var.environment}_default_sg"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${compact(split(",", var.allowed_ips))}"]
    self        = true
  }

  ingress {
    from_port   = "-1"
    to_port     = "-1"
    protocol    = "icmp"
    cidr_blocks = ["${compact(split(",", var.allowed_ips))}"]
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.environment}_default_sg"
    Description = "${var.environment}_default_sg"
    project     = "${var.project}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
    email       = "${var.email}"
  }
}
