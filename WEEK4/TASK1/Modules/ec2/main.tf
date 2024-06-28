resource "aws_instance" "ec2_instance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)
  associate_public_ip_address = true
   key_name      = "sarahkeypair2"

  tags = {
    Name = "EC2 Instance ${count.index + 1}"
  }
}
