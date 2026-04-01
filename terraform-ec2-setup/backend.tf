terraform {
  backend "s3" {
    bucket         = "aswani-terraform-state-2026"
    key            = "ec2-project/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
