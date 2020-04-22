
resource "aws_codedeploy_app" "aip-smartall-api" {
  name                    = "aip-smartall-api"
  compute_platform        = "Server"
}

resource "aws_codedeploy_deployment_group" "aip-smartall-api-deploy-group" {
  deployment_group_name   = "prd-aip-deploy-group"
  deployment_config_name  = "CodeDeployDefault.AllAtOnce"
  app_name                = aws_codedeploy_app.aip-smartall-api.name
  service_role_arn        = data.aws_iam_role.prd-com-codedeploy-role.arn
  autoscaling_groups      = [ "prd-aip-smartall-api-ag"]

  deployment_style {
    deployment_type       = "IN_PLACE" # IN_PLACE or BLUE_GREEN
    # deployment_type:    IN_PLACE or BLUE_GREEN. Default is IN_PLACE.
    # deployment_option:  WITH_TRAFFIC_CONTROL or WITHOUT_TRAFFIC_CONTROL. Default is WITHOUT_TRAFFIC_CONTROL.
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_codedeploy_app" "aip-service" {
  name                    = "aip-service"
  compute_platform        = "Server"
}

resource "aws_codedeploy_deployment_group" "aip-service-deploy-group" {
  deployment_group_name   = "prd-aip-deploy-group"
  deployment_config_name  = "CodeDeployDefault.OneAtATime"
  app_name                = aws_codedeploy_app.aip-service.name
  service_role_arn        = data.aws_iam_role.prd-com-codedeploy-role.arn
  autoscaling_groups      = [ "prd-aip-service-ag"]

  deployment_style {
    deployment_type       = "IN_PLACE"
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_codedeploy_app" "aip-stream" {
  name                    = "aip-stream"
  compute_platform        = "Server"
}

resource "aws_codedeploy_deployment_group" "aip-stream-deploy-group" {
  deployment_group_name   = "prd-aip-deploy-group"
  deployment_config_name  = "CodeDeployDefault.OneAtATime"
  app_name                = aws_codedeploy_app.aip-stream.name
  service_role_arn        = data.aws_iam_role.prd-com-codedeploy-role.arn
  autoscaling_groups      = [ "prd-aip-stream-ag"]

  deployment_style {
    deployment_type       = "IN_PLACE"
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_codedeploy_app" "aip-bookclub-api" {
  name                    = "aip-bookclub-api"
  compute_platform        = "Server"
}

resource "aws_codedeploy_deployment_group" "aip-bookclub-api-deploy-group" {
  deployment_group_name   = "prd-aip-deploy-group"
  deployment_config_name  = "CodeDeployDefault.OneAtATime"
  app_name                = aws_codedeploy_app.aip-bookclub-api.name
  service_role_arn        = data.aws_iam_role.prd-com-codedeploy-role.arn
  autoscaling_groups      = [ "prd-aip-bookclub-api-ag"]

  deployment_style {
    deployment_type       = "IN_PLACE"
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_codedeploy_app" "aip-redpipe-sender" {
  name                    = "aip-redpipe-sender"
  compute_platform        = "Server"
}

resource "aws_codedeploy_deployment_group" "aip-redpipe-sender-deploy-group" {
  deployment_group_name   = "prd-aip-deploy-group"
  deployment_config_name  = "CodeDeployDefault.OneAtATime"
  app_name                = aws_codedeploy_app.aip-redpipe-sender.name
  service_role_arn        = data.aws_iam_role.prd-com-codedeploy-role.arn
  autoscaling_groups      = [ "prd-aip-redpipe-sender-ag"]

  deployment_style {
    deployment_type       = "IN_PLACE"
  }

  lifecycle {
    ignore_changes = all
  }
}