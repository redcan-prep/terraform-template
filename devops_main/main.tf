provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    terraform = {
      source = "terraform.io/builtin/terraform"
    }
  }
}

locals {
  project_name = "devops_2024"
  # workspace_var  = jsondecode(file("${terraform.workspace}.tfvars.json"))
  workspace_var2 = provider::terraform::decode_tfvars(file("${terraform.workspace}/${terraform.workspace}.tfvars"))
}

module "vpc" {
  source         = "../modules/vpc"
  vpc_name       = "${local.project_name}_vpc_${terraform.workspace}"
  vpc_cidr_block = "${terraform.workspace}" == "dev" ? "10.0.0.0/16" : "10.10.0.0/16"
}

module "subnets" {
  source             = "../modules/subnet"
  vpc_id             = module.vpc.vpc_id
  public_subnet_name = "dev-public-subnet"
  # public_subnet_cidrs  = ["10.0.10.0/24", "10.0.20.0/24"]
  # private_subnet_cidrs = ["10.0.100.0/24", "10.0.200.0/24"]
  private_subnet_name  = "dev-private-subnet"
  public_subnet_cidrs  = local.workspace_var2.public_subnet_cidrs
  private_subnet_cidrs = local.workspace_var2.private_subnet_cidrs
}

module "internet_gateway" {
  source  = "../modules/internet-gateway"
  vpc_id  = module.vpc.vpc_id
  ig_name = "devops-2024-ig"
}

module "route_table" {
  source           = "../modules/route-table"
  route-table-name = "devops-2024-routetable"
  vpc_id           = module.vpc.vpc_id
  ig_id            = module.internet_gateway.ig-id
  public_subnet    = module.subnets.public_subnet_id
  # multiple_routes = [
  #   { cidr_block = "10.0.10.0/24", internet_gateway = module.internet_gateway.ig-id },
  #   { cidr_block = "10.0.20.0/24", internet_gateway = module.internet_gateway.ig-id }
  # ]
  # public_subnet = ["10.0.10.0/24", "10.0.20.0/24", "10.0.100.0/24", "10.0.200.0/24"]
}

module "security_group" {
  source            = "../modules/security-groups"
  sg_name           = "devops-2024-security-group"
  vpc_id            = module.vpc.vpc_id
  public_cidr_block = module.subnets.public_subnet_cidrs
}

module "instance-1" {
  source         = "../modules/ec2"
  name           = "webserver-1-${terraform.workspace}"
  subnet_id      = module.subnets.public_subnet_id[1]
  security_group = module.security_group.aws_security_group
  instance_type  = local.workspace_var2.instance_type
}

module "instance-2" {
  source         = "../modules/ec2"
  name           = "webserver-2-${terraform.workspace}"
  subnet_id      = module.subnets.public_subnet_id[1]
  security_group = module.security_group.aws_security_group
  instance_type  = local.workspace_var2.instance_type
}

# module "security_group_ec2" {
#   source            = "../modules/security-groups"
#   sg_name           = "devops-2024-security-group"
#   vpc_id            = module.vpc.vpc_id
#   public_cidr_block = module.subnets.public_subnet_cidrs
# }

module "s3" {
  source      = "../modules/s3"
  bucket_name = "devops-2024-terraform-project3-${terraform.workspace}"
}
