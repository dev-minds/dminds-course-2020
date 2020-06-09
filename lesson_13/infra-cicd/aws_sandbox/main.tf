provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_version = ">= 0.12.24"

  backend "s3" {
    bucket  = "sandbox-acct-states"
    key     = "sandbox/management-env.tfstate"
    region  = "eu-west-1"
    encrypt = "true"
  }
}

module "vpc" {
  source = "git::https://github.com/dev-minds/tf_modules.git//fm_vpc_mod/dm_simple_vpc?ref=master"

  ip_range = "10.10.0.0/16"
  name_tag = "management"

  dns_support = "true"
  dns_hostn   = "true"

  pub_ip_range = ["10.10.5.0/24", "10.10.6.0/24", "10.10.7.0/24"]
  pub_azs      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

  priv_ip_range = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  priv_azs      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

  enabled_nat_gateway        = "false"
  enabled_single_nat_gateway = "false"
}
