# I will be creating my VPC resource here, and define all the relelvant options and arguments 

resource "aws_vpc" "dminds_vpc_res" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"


  tags = merge({
    "Name" = "Preprod_Datacentre"
  })
}

resource "aws_internet_gateway" "dminds_ig_res" {
  vpc_id = aws_vpc.dminds_vpc_res.id

  tags = merge({
    "Name" = "Preprod_IG"
  })

}