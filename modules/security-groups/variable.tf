variable "vpc_id" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "public_cidr_block" {
  type = list(string)
}
