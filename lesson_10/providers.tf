# I am telling terraform i will use AWS provider here 

provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.7"
}