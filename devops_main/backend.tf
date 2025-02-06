terraform {
  backend "s3" {
    bucket  = "devops-terraform-2024"
    region  = "us-east-1"
    key     = "terraform/state/terraform.tfstate"
    encrypt = true
  }
}
