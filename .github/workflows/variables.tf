variable "aws_region" {
  description = "The AWS region to create resources in."
  default     = "us-east-1"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet."
  default     = "10.0.6.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet."
  default     = "10.0.5.0/24"
}
