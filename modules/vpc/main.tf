resource "aws_vpc" "vpc_devops" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}