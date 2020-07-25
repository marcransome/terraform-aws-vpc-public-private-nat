variable "vpc_name" {
    type        = string
    description = "The name for the VPC"
}

variable "vpc_cidr" {
    type        = string
    default     = "10.0.0.0/16"
    description = "The CIDR block for the VPC"
}

variable "public_subnet_name" {
    type        = string
    default     = "Public subnet"
    description = "The name for the public subnet"
}

variable "public_subnet_cidr" {
    type        = string
    default     = "10.0.0.0/24"
    description = "The CIDR block for the public subnet"
}

variable "private_subnet_name" {
    type        = string
    default     = "Private subnet"
    description = "The name for the private subnet"
}

variable "private_subnet_cidr" {
    type        = string
    default     = "10.0.1.0/24"
    description = "The CIDR block for the private subnet"
}

variable "aws_availability_zone" {
    type        = string
    description = "The availability zone for the public and private subnets"
}
