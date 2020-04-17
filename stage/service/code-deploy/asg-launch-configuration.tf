resource "aws_launch_configuration" "stg-aip-redpipe-20200416" {
  name            = "stg-aip-redpipe-20200416"
  image_id        = var.redpipe-ami_id
  instance_type   = "t3.small"
  key_name        = var.keypair-map.prd-aip
  security_groups = [ security-group-map.stg-aip-redpipe-sender-sg, security-group-map.stg-aip-mgmt-sg ]

//  user_data = <<USER_DATA
//#!/bin/bash
//java -jar /home/ubuntu/backend-demo-1.0.0-SNAPSHOT.jar &
//  USER_DATA

  lifecycle {
    create_before_destroy = true
  }

}
