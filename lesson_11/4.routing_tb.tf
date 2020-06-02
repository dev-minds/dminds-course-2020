resource "aws_route_table" "dminds_rt_res" {
  vpc_id = aws_vpc.dminds_vpc_res.id

  tags = merge({
    "Name" = "PreProdPublicRouteTable"
  })
}

resource "aws_route" "dminds_rt_igw_res" {
  route_table_id         = aws_route_table.dminds_rt_res.id
  gateway_id             = aws_internet_gateway.dminds_ig_res.id
  destination_cidr_block = "0.0.0.0/0"
}


resource "aws_route_table_association" "dminds_rtt_assoc_res" {
  count          = length(var.pub_ip_range)
  subnet_id      = aws_subnet.dminds_sb_pb.*.id[count.index]
  route_table_id = aws_route_table.dminds_rt_res.id
}