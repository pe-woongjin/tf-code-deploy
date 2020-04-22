data "aws_vpc" "prd-aip" {
  id = var.prd-aip-vpc_id
}

data "aws_security_group" "prd-aip-redpipe-sender-sg" {
  id = "sg-028cb5c4a92ea3acf"
}

data "aws_security_group" "prd-aip-mgmt-sg" {
  id = "sg-0493ac0d8ddcf7a0c"
}

