provider "aws" {
  region = var.aws_region
}

module "vpc_network" {
  source = "./modules/vpc"

  vpc_cidr = "10.0.0.0/16"
}

module "ec2_instance" {
  source = "./modules/ec2"

  instance_count = 2
  instance_type  = "t2.micro"
  ami            = "ami-01e076d5c9e040974"  # Replace with your actual AMI ID
  subnet_ids     = module.vpc_network.subnet_ids
}

module "rds_database" {
  source = "./modules/rds"

  db_instance_class = "db.t3.micro"
  db_engine         = "mysql"
  db_engine_version = "5.7"
  db_name           = "sarahrds1"  # Replace with your actual RDS database name
  subnet_ids        = module.vpc_network.subnet_ids
  vpc_id            = module.vpc_network.vpc_id
}

output "ec2_instance_ips" {
  value = module.ec2_instance.instance_ips
}

output "vpc_id" {
  value = module.vpc_network.vpc_id
}

output "rds_endpoint" {
  value = module.rds_database.db_endpoint
}
