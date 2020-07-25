output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC"
}

output "public_subnet_id" {
  value       = aws_subnet.public_subnet.id
  description = "The ID of the public subnet"
}

output "private_subnet_id" {
  value       = aws_subnet.private_subnet.id
  description = "The ID of the private subnet"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.gateway.id
  description = "The ID of the internet gateway"
}

output "nat_instance_id" {
  value       = aws_nat_gateway.nat_gateway.id
  description = "The ID of the NAT gateway"
}
