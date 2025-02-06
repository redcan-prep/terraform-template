resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.ig_id
  }

  tags = {
    Name = var.route-table-name
  }

}

# Route Table Association
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet)
  subnet_id      = var.public_subnet[count.index]
  route_table_id = aws_route_table.route_table.id
}






# dynamic "route" {
#   for_each = var.multiple_routes
#   iterator = item   #optional
#   content {
#     cidr_block = item.value.cidr_block
#     gateway_id = item.value.internet_gateway
#   }
# }
