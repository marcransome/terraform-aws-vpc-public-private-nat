resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "vpc-${var.vpc_name}"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.aws_availability_zone

    tags = {
      Name = "subnet-${var.public_subnet_name}"
      Description = "Public subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.aws_availability_zone

    tags = {
      Name = "subnet-${var.private_subnet_name}"
      Description = "Private subnet"
    }
}

resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "internet-gateway-${var.vpc_name}"
        Description = "Internet gateway"
    }
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.nat_gateway.id
    subnet_id = aws_subnet.public_subnet.id

    tags = {
        Name = "nat-gateway-${var.public_subnet_name}"
        Description = "Public facing NAT gateway"
    }
}

resource "aws_route_table" "public_subnet" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
    }

    tags = {
      Name = "route-table-${var.public_subnet_name}"
      Description = "Routing table for public subnet"
    }
}

resource "aws_route_table_association" "public_subnet" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_subnet.id
}

resource "aws_route_table" "private_subnet" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gateway.id
    }

    tags = {
      Name = "route-table-${var.private_subnet_name}"
      Description = "Routing table for private subnet"
    }
}

resource "aws_route_table_association" "private_subnet" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_subnet.id
}

resource "aws_eip" "nat_gateway" {
    vpc = true

    tags = {
      Name = "elastic-ip-nat-gateway-${var.public_subnet_name}"
      Description = "Elastic IP for public facing NAT instance"
    }
}

resource "aws_network_acl" "public_subnet" {

    vpc_id = aws_vpc.vpc.id
    subnet_ids = [aws_subnet.public_subnet.id]

    ingress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 80
        to_port     = 80
    }

    ingress {
        protocol    = "tcp"
        rule_no     = 110
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 443
        to_port     = 443
    }

    ingress {
        protocol    = "tcp"
        rule_no     = 120
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 22
        to_port     = 22
    }

    ingress {
        protocol   = "tcp"
        rule_no    = 130
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 1024
        to_port    = 65535
    }

    ingress {
        protocol    = -1
        rule_no     = 140
        action      = "deny"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0
    }

    egress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 80
        to_port     = 80
    }

    egress {
        protocol   = "tcp"
        rule_no    = 110
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 443
        to_port    = 443
    }

    egress {
        protocol    = "tcp"
        rule_no     = 120
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 1024
        to_port     = 65535
    }

    egress {
        protocol   = "tcp"
        rule_no    = 400
        action     = "allow"
        cidr_block = var.private_subnet_cidr
        from_port  = 22
        to_port    = 22
    }

    egress {
        protocol   = -1
        rule_no    = 1000
        action     = "deny"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    tags = {
        Name = "network-acl-${var.public_subnet_name}"
        Description = "ACL rules for public subnet"
    }
}

resource "aws_network_acl" "private_subnet" {

    vpc_id = aws_vpc.vpc.id
    subnet_ids = [aws_subnet.private_subnet.id]

    ingress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block  = var.public_subnet_cidr
        from_port   = 22
        to_port     = 22
    }

    ingress {
        protocol    = "tcp"
        rule_no     = 110
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 1024
        to_port     = 65535
    }

    ingress {
        protocol    = -1
        rule_no     = 120
        action      = "deny"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0
    }

    egress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 80
        to_port     = 80
    }

    egress {
        protocol    = "tcp"
        rule_no     = 110
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 443
        to_port     = 443
    }

    egress {
        protocol    = "tcp"
        rule_no     = 120
        action      = "allow"
        cidr_block  = var.public_subnet_cidr
        from_port   = 32768
        to_port     = 65535
    }

    egress {
        protocol    = -1
        rule_no     = 130
        action      = "deny"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0
    }

    tags = {
        Name = "network-acl-${var.private_subnet_name}"
        Description = "ACL rules for private subnet"
    }
}
