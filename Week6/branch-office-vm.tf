resource "aws_instance" "branch_office_vm" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  tags = {
    Name = "BranchOfficeVM"
  }
}
