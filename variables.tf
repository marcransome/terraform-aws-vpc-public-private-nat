variable "vpc_name" {
    type        = "string"
    description = ""
}

variable "vpc_cidr" {
    type        = "string"
    default     = "10.0.0.0/16"
    description = ""
}

variable "public_subnet_name" {
    type        = "string"
    default     = "Public subnet"
    description = ""
}

variable "public_subnet_cidr" {
    type        = "string"
    default     = "10.0.0.0/24"
    description = ""
}

variable "private_subnet_name" {
    type        = "string"
    default     = "Private subnet"
    description = ""
}

variable "private_subnet_cidr" {
    type        = "string"
    default     = "10.0.1.0/24"
    description = ""
}

variable "aws_availability_zone" {
    type        = "string"
    description = ""
}

