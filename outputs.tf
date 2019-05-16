output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}

output "private_subnet_id" {
  value = "${aws_subnet.private_subnet.id}"
}

output "internet_gateway_id" {
  value = "${aws_internet_gateway.gateway.id}"
}

output "nat_instance_id" {
  value = "${aws_nat_gateway.nat_gateway.id}"
}

