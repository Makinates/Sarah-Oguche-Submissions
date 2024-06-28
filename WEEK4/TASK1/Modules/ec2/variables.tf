variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
}

variable "ami" {
  description = "AMI ID for EC2 instances"
  type        = string
}
variable "subnet_ids" {
  description = "List of Subnet IDs where the instances will be launched"
  type        = list(string)
}
