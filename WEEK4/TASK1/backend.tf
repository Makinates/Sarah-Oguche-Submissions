terraform {
  backend "s3" {
    bucket         = "sarah-bucket3"
    key            = ".terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "table1"
  }
}
