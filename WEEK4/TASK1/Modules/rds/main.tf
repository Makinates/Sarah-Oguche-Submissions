resource "aws_db_subnet_group" "default" {
  name       = "main-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "main-subnet-group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = "admin"
  password             = "password123"  # Use a more secure password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default.name

  tags = {
    Name = "main-rds-instance"
  }
}
