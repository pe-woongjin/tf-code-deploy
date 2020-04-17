
resource "aws_autoscaling_group" "prd-aip-stream-ag" {
  name                  = "prd-aip-stream-ag"
  vpc_zone_identifier   = [ data.aws_subnet.prd-aip-private-c-sn.id ]
  availability_zones    = [ "ap-northeast-2c" ]
  desired_capacity      = 0
  min_size              = 0
  max_size              = 4
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.prd-aip-stream-lt.id
    version = "$Default"
  }

  enabled_metrics = [ "GroupInServiceInstances", "GroupMaxSize", "GroupStandbyInstances",
    "GroupDesiredCapacity", "GroupTotalInstances", "GroupTerminatingInstances",
    "GroupMinSize", "GroupPendingInstances" ]

  tag {
    key                 = "Name"
    value               = "prd-aip-stream-ag"
    propagate_at_launch = true
  }

}


resource "aws_autoscaling_group" "prd-aip-bookclub-api-ag" {
  name                  = "prd-aip-bookclub-api-ag"
  vpc_zone_identifier   = [  data.aws_subnet.prd-aip-private-a-sn.id, data.aws_subnet.prd-aip-private-c-sn.id ]
  availability_zones    = [ "ap-northeast-2a", "ap-northeast-2c" ]
  desired_capacity      = 0
  min_size              = 0
  max_size              = 2
  health_check_grace_period = 120

  target_group_arns     = [ data.aws_alb_target_group.prd-aip-services-default-tg.arn,
    data.aws_alb_target_group.prd-aip-services-detail-tg.arn,
    data.aws_alb_target_group.prd-aip-services-realtime-tg.arn ]

  launch_template {
    id      = aws_launch_template.prd-aip-bookclub-api-lt.id
    version = "$Default"
  }

  enabled_metrics = [ "GroupTerminatingInstances", "GroupMinSize", "GroupTotalInstances",
    "GroupInServiceInstances", "GroupMaxSize", "GroupPendingInstances",
    "GroupStandbyInstances", "GroupDesiredCapacity" ]

  tag {
    key                 = "Name"
    value               = "prd-aip-bookclub-api"
    propagate_at_launch = true
  }

}


resource "aws_autoscaling_group" "prd-aip-smartall-api-ag" {
  name                  = "prd-aip-smartall-api-ag"
  vpc_zone_identifier   = [  data.aws_subnet.prd-aip-private-a-sn.id ]
  availability_zones    = [ "ap-northeast-2a"]
  desired_capacity      = 0
  min_size              = 0
  max_size              = 2
  health_check_grace_period = 300

  target_group_arns     = [
    data.aws_alb_target_group.prd-aip-nftf-peers-detail-tg.arn,
    data.aws_alb_target_group.prd-aip-nftf-quest-detail-tg.arn,
    data.aws_alb_target_group.prd-aip-nftf-quest-real-tg.arn,
    data.aws_alb_target_group.prd-aip-nftf-unit-detail-tg.arn
  ]

  launch_template {
    id      = aws_launch_template.prd-aip-smartall-api-lt.id
    version = "$Default"
  }

  enabled_metrics = [ "GroupMaxSize", "GroupStandbyInstances", "GroupPendingInstances",
    "GroupDesiredCapacity", "GroupPendingCapacity", "GroupTotalCapacity",
    "GroupTotalInstances", "GroupStandbyCapacity", "GroupTerminatingInstances",
    "GroupTerminatingCapacity", "GroupInServiceCapacity", "GroupMinSize",
    "GroupInServiceInstances" ]

  tag {
    key                 = "Name"
    value               = "prd-aip-smartall-api"
    propagate_at_launch = true
  }

}


resource "aws_autoscaling_group" "prd-aip-service-ag" {
  name                  = "prd-aip-service-ag"
  vpc_zone_identifier   = [  data.aws_subnet.prd-aip-private-a-sn.id, data.aws_subnet.prd-aip-private-c-sn.id ]
  availability_zones    = [ "ap-northeast-2a", "ap-northeast-2c" ]
  desired_capacity      = 0
  min_size              = 0
  max_size              = 6
  health_check_grace_period = 120

  target_group_arns     = [
    data.aws_alb_target_group.prd-aip-services-event-tg.arn,
    data.aws_alb_target_group.prd-aip-services-ingestion-tg.arn,
    data.aws_alb_target_group.prd-aip-services-insight-tg.arn,
    data.aws_alb_target_group.prd-aip-services-metric-tg.arn
  ]

  launch_template {
    id      = aws_launch_template.prd-aip-service-lt.id
    version = "$Default"
  }

  enabled_metrics = [ "GroupTerminatingInstances", "GroupMinSize", "GroupTotalInstances",
    "GroupInServiceInstances", "GroupMaxSize", "GroupPendingInstances",
    "GroupStandbyInstances", "GroupDesiredCapacity" ]

  tag {
    key                 = "Name"
    value               = "prd-aip-service"
    propagate_at_launch = true
  }

}


## working
resource "aws_autoscaling_group" "prd-aip-redpipe-sender-ag" {
  name                  = "prd-aip-redpipe-sender-ag"
  vpc_zone_identifier   = [  data.aws_subnet.prd-aip-private-c-sn.id ]
  availability_zones    = [ "ap-northeast-2c" ]
  desired_capacity      = 0
  min_size              = 0
  max_size              = 1
  health_check_grace_period = 120
  # target_group_arns     = [ ]
  launch_configuration = aws_launch_configuration.prd-aip-redpipe-20200416.id

  enabled_metrics = [ "GroupMaxSize", "GroupStandbyInstances", "GroupPendingInstances",
    "GroupInServiceInstances", "GroupTerminatingInstances", "GroupDesiredCapacity",
    "GroupTotalInstances", "GroupMinSize" ]

  tag {
    key                 = "Name"
    value               = "prd-aip-redpipe-sender"
    propagate_at_launch = true
  }

}