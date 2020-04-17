variable "redpipe-ami_id" {
  description = "redpipe-ami_id"
  type = string
}

variable "security-group-map" {
  description = "security group map"
  type = map(string)
}

variable "keypair-map" {
  description = "keypairs for ec2"
  type = map(string)
}

# ######################
# VPC
# ######################
# vpc id
variable "vpc_id" {
  type        = string
  description = "vpc id"
}
