# vpc id
variable "aip-vpc_id" {
  type        = string
  description = "aip-vpc_id"
}

variable "prd-aip-ami_id" {
  description = "prd-aip-ami_id"
  type = string
}

variable "security-group-map" {
  description = "security groups"
  type = map(string)
  default = {
    "prd-aip-redpipe-sender-sg" = "sg-028cb5c4a92ea3acf"
    "prd-aip-mgmt-sg"           = "sg-0493ac0d8ddcf7a0c"
    "prd-aip-smartall-api-sg"   = "sg-09ed83df0a47f116c"
    "prd-aip-bookclub-api-sg"   = "sg-071630dc187cb4a44"
    "prd-aip-stream-sg"         = "sg-08c5743ba51850bd0"
    "prd-aip-service-sg"        = "sg-07d5711351c11155c"
    "stg-aip-redpipe-sender-sg" = "todo"
    "stg-aip-mgmt-sg"           = "todo"
    }
}

variable "keypair-map" {
  description = "key-pairs for ec2"
  type = map(string)
  default = {
    "prd-aip-keypair" = "prd-aip-keypair"
    "stg-aip" = "stg-aip-keypair"
  }
}

variable "aip-ebs-snapshot_id" {
  type        = string
  description = "aip-ebs-snapshot_id"
  default = "snap-0cbb59dd32bab1541"
}