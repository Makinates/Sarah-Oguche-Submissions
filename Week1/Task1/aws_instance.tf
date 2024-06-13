//Launching the EC2 Instance
resource "aws_instance" "web_instance" {
  ami                         = "ami-001bcde70c5ceaee6"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_a.id
  associate_public_ip_address = true
  security_groups             = ["sg-0f5e825820d96a3c5"]

  tags = {
    Name = "web_instance"
  }
}
