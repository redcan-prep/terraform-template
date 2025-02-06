variable "route-table-name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ig_id" {
  type = string
}

variable "public_subnet" {
  type = list(string)
}

