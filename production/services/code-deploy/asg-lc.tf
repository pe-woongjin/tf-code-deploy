resource "aws_launch_configuration" "prd-aip-redpipe-20200416" {
  name            = "prd-aip-redpipe-20200416"
  image_id        = "ami-06b45d6f4c5d49635"
  instance_type   = "t3.small"
  ebs_optimized   = true
  enable_monitoring = true
  key_name        = var.keypair-map.prd-aip-keypair

  security_groups = [ var.security-group-map.prd-aip-redpipe-sender-sg, var.security-group-map.prd-aip-mgmt-sg ]

//  count                     = length(var.ui_sn_list)
//  cidr_block                = lookup(var.ui_sn_list[count.index], "cidr_block")
//  availability_zone         = lookup(var.ui_sn_list[count.index], "availability_zone")

//  user_data = <<USER_DATA
//  USER_DATA

  lifecycle {
    create_before_destroy = true
  }

}

