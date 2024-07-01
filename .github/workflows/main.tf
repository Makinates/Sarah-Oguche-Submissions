provider "aws" {
  region = "us-east-1"
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = "vpc-05b0ca6c03e94aa26"
  cidr_block        = "10.0.6.0/24"  # Updated CIDR block
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public Subnet"
  }
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = "vpc-05b0ca6c03e94aa26"
  cidr_block        = "10.0.5.0/24"  # Updated CIDR block
  availability_zone = "us-east-1a"
  tags = {
    Name = "Private Subnet"
  }
}

# Security Group for public subnet
resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "Allow SSH and HTTP"
  vpc_id      = "vpc-05b0ca6c03e94aa26"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for private subnet
resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  description = "Allow internal traffic"
  vpc_id      = "vpc-05b0ca6c03e94aa26"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# NAT Gateway and EIP
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
}

# Public route table
resource "aws_route_table" "public_rt" {
  vpc_id = "vpc-05b0ca6c03e94aa26"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-0256891a23a381290"
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Private route table
resource "aws_route_table" "private_rt" {
  vpc_id = "vpc-05b0ca6c03e94aa26"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "private_rt_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# IAM Role for developers
resource "aws_iam_role" "developer_role" {
  name = "developer_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# IAM Policy for developers
resource "aws_iam_policy" "developer_policy" {
  name = "developer_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "s3:ListBucket",
          "s3:GetObject"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "developer_attach" {
  role       = aws_iam_role.developer_role.name
  policy_arn = aws_iam_policy.developer_policy.arn
}

# Secrets Manager for storing credentials
resource "aws_secretsmanager_secret" "db_credentials" {
  name = "db_credentials"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "admin"
    password = "your_password"
  })
}

# Bastion Host
resource "aws_instance" "bastion" {
  ami           = "ami-01e076d5c9e040974"  # Example Amazon Linux 2 AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.public_sg.id]

  key_name = "sarahkeypair2"

  tags = {
    Name = "Bastion Host"
  }
}

# App Server
resource "aws_instance" "app_server" {
  ami           = "ami-01e076d5c9e040974"  # Example Amazon Linux 2 AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.private_sg.id]

  key_name = "sarahkeypair2"

  tags = {
    Name = "App Server"
  }
}
