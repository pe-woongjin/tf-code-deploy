resource "aws_dynamodb_table" "terraform_state_lock" {
  name = "TerraformStateLock"
  read_capacity = 5
  write_capacity = 5
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "kr.ne.outsider.logs"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "terraform-state" {
  bucket = "kr.ne.outsider.terraform.state"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name = "terraform state"
  }
  logging {
    target_bucket = aws_s3_bucket.logs.id
    target_prefix = "log/"
  }
  lifecycle {
    prevent_destroy = false
  }
}


terraform {
  required_version = "~> 0.12.20"
  backend "local" {}

//  backend "s3" {
//      bucket = "kr.ne.outsider.terraform.state"
//      key = "test/terraform_remote.tfstate"
//      region = "ap-northeast-2"
//      // encrypt = true
//      dynamodb_table = "TerraformStateLock"
//      acl = "bucket-owner-full-control"
//  }

}

provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region = "ap-northeast-2"
  version = "~> 2.51"
}




