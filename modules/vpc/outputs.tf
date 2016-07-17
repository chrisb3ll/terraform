# outputs

output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "public_subnets" {
  value = "${join(",", aws_subnet.public.*.id)}"
}

output "private_subnets" {
  value = "${join(",", aws_subnet.private.*.id)}"
}

output "public_route_table_id" {
  value = "${aws_route_table.public.id}"
}

output "private_route_tables" {
  value = "${join(",", aws_route_table.private.*.id)}"
}

output "default_sg_id" {
  value = "${aws_security_group.default_sg.id}"
}
