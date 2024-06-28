variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "ec2_ami" {
  description = "EC2 instance AMI ID"
}

variable "db_name" {
  description = "Name of the RDS database"
}
