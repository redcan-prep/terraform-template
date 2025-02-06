variable "ami" {
  default     = "ami-0866a3c8686eaeeba"
  type        = string
  description = "AMI Value"
}

variable "instance_type" {
  default     = "t2.micro"
  type        = string
  description = "Instance Type"
}

variable "name" {
  type = string
}

variable "subnet_id" {
  type = string
}

# variable "ingress_security_group_id" {
#   type = string
# }

# variable "ingress_ipv4_port80" {
#   type = string
# }


# variable "egress_security_group_id" {
#   type = string
# }

variable "security_group" {
  type = string
}
