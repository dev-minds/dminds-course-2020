# I wish to use this to create an s3 bucket 

resource "aws_s3_bucket" "friday_buck" {
  bucket = "friday-tf-demo-bucket-resource-da"
  acl    = "private"

  tags = {
    Name        = "Fmbah"
    Environment = "Staging"
  }
}

resource "aws_s3_bucket" "friday_test_buck" {
  bucket = "friday-tf-demo-bucket-resource-sa"
  acl    = "private"

  tags = {
    Name        = "Fmbah"
    Environment = "Staging"
  }
}

resource "aws_s3_bucket" "friday_test_buck_tp" {
  bucket = "friday-tf-demo-bucket-resource-sa"
  acl    = "private"

  tags = {
    Name        = "Fmbah"
    Environment = "Staging"
  }
} 