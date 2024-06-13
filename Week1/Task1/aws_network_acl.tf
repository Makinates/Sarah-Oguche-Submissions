//Create Network ACL
resource "aws_network_acl" "main_acl" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "main_acl"
  }
}

resource "aws_network_acl_association" "subnet_a_acl_association" {
  subnet_id       = aws_subnet.subnet_a.id
  network_acl_id  = aws_network_acl.main_acl.id
}

resource "aws_network_acl_association" "subnet_b_acl_association" {
  subnet_id       = aws_subnet.subnet_b.id
  network_acl_id  = aws_network_acl.main_acl.id
}