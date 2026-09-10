terraform {
  backend "s3" {
    bucket         = "devops1910-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devops1910-terraform-locks"
    encrypt        = true
  }
}
