resource "aws_security_group" "security_group" {
  vpc_id = var.vpc_id


  tags = {
    Name = var.sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ipv4" {
  security_group_id = aws_security_group.security_group.id
  count             = length(var.public_cidr_block)
  cidr_ipv4         = var.public_cidr_block[count.index]
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "egress_ipv4" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ipv4_ssh" {
  security_group_id = aws_security_group.security_group.id
  # count             = length(var.public_cidr_block)
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ipv4_port80" {
  security_group_id = aws_security_group.security_group.id
  # count             = length(var.public_cidr_block)
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}
