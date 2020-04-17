
resource "aws_launch_template" "prd-aip-service-lt" {
  name            = "prd-aip-service-lt"
  description     = "prd-aip-service-auto"
  image_id        = var.prd-aip-ami_id
  instance_type   = "t3.large"
  key_name        = var.keypair-map.prd-aip-keypair
  vpc_security_group_ids = [ var.security-group-map.prd-aip-mgmt-sg, var.security-group-map.prd-aip-service-sg ]

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
      volume_type = "gp2"
      snapshot_id = var.aip-ebs-snapshot_id
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = "prd-aip-service"
    }
  }

  user_data = base64encode(templatefile("./services/code-deploy/aip-api-userdata.tpl", {}))

  lifecycle {
    create_before_destroy = true
  }

}



resource "aws_launch_template" "prd-aip-smartall-api-lt" {
  name            = "prd-aip-smartall-api-lt"
  image_id        = var.prd-aip-ami_id
  instance_type   = "t3.large"
  key_name        = var.keypair-map.prd-aip-keypair
  vpc_security_group_ids = [ var.security-group-map.prd-aip-mgmt-sg, var.security-group-map.prd-aip-smartall-api-sg ]

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
      volume_type = "gp2"
      snapshot_id = var.aip-ebs-snapshot_id
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = "prd-aip-smartall-api"
    }
  }

  user_data = base64encode(templatefile("./services/code-deploy/aip-api-userdata.tpl", {}))

  lifecycle {
    create_before_destroy = true
  }

}






resource "aws_launch_template" "prd-aip-bookclub-api-lt" {
  name            = "prd-aip-bookclub-api-lt"
  image_id        = var.prd-aip-ami_id
  instance_type   = "t3.large"
  key_name        = var.keypair-map.prd-aip-keypair
  vpc_security_group_ids = [ var.security-group-map.prd-aip-mgmt-sg, var.security-group-map.prd-aip-bookclub-api-sg ]

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
      volume_type = "gp2"
      snapshot_id = var.aip-ebs-snapshot_id
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = "prd-aip-bookclub-api"
    }
  }

  user_data = base64encode(templatefile("./services/code-deploy/aip-api-userdata.tpl", {}))

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_launch_template" "prd-aip-stream-lt" {
  name            = "prd-aip-stream-lt"
  image_id        = var.prd-aip-ami_id
  instance_type   = "t3.small"
  key_name        = var.keypair-map.prd-aip-keypair
  vpc_security_group_ids = [ var.security-group-map.prd-aip-mgmt-sg, var.security-group-map.prd-aip-stream-sg ]

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
      volume_type = "gp2"
      snapshot_id = var.aip-ebs-snapshot_id
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = "prd-aip-stream"
    }
  }

  user_data = base64encode(templatefile("./services/code-deploy/aip-stream-userdata.tpl", {}))

  lifecycle {
    create_before_destroy = true
  }

}
