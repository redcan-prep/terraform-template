resource "aws_subnet" "public_subnet" {
  vpc_id     = var.vpc_id
  count      = length(var.public_subnet_cidrs)
  cidr_block = var.public_subnet_cidrs[count.index]

  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = var.vpc_id
  count      = length(var.private_subnet_cidrs)
  cidr_block = var.private_subnet_cidrs[count.index]

  tags = {
    Name = var.private_subnet_name
  }
}
