# I am creating my subnets/route tables etc here 


resource "aws_subnet" "dminds_sb_pb" {
  count                   = length(var.pub_ip_range)
  vpc_id                  = aws_vpc.dminds_vpc_res.id
  cidr_block              = var.pub_ip_range[count.index]
  availability_zone       = var.pub_azs[count.index]
  map_public_ip_on_launch = true

  tags = merge({
    "Name" = "PreProdPublicSubnet"
  })

}