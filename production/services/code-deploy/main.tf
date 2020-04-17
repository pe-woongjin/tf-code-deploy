data "aws_subnet" "prd-aip-private-a-sn" {
  id = "subnet-017c11fb589336abc"
}

data "aws_subnet" "prd-aip-private-c-sn" {
  id = "subnet-0a8df90f705e80b03"
}

data "aws_alb_target_group" "prd-aip-services-default-tg" {
  arn = "arn:aws:elasticloadbalancing:ap-northeast-2:618467231866:targetgroup/prd-aip-services-default-tg/5cb164560adb5db4"
}

data "aws_alb_target_group" "prd-aip-services-detail-tg" {
  arn = "arn:aws:elasticloadbalancing:ap-northeast-2:618467231866:targetgroup/prd-aip-services-detail-tg/90252f06a635dd7d"
}

data "aws_alb_target_group" "prd-aip-services-realtime-tg" {
  arn = "arn:aws:elasticloadbalancing:ap-northeast-2:618467231866:targetgroup/prd-aip-services-realtime-tg/fc30d752186f950a"
}

data "aws_alb_target_group" "prd-aip-nftf-peers-detail-tg" {
  arn = "arn:aws:elasticloadbalancing:ap-northeast-2:618467231866:targetgroup/prd-aip-nftf-peers-detail-tg/cac533d6f640df2c"
}

data "aws_alb_target_group" "prd-aip-nftf-quest-detail-tg" {
  arn = "arn:aws:elasticloadbalancing:ap-northeast-2:618467231866:targetgroup/prd-aip-nftf-quest-detail-tg/226d163552fcf996"
}

data "aws_alb_target_group" "prd-aip-nftf-quest-real-tg" {
  arn = "arn:aws:elasticloadbalancing:ap-northeast-2:618467231866:targetgroup/prd-aip-nftf-quest-real-tg/5ad89e71bd7b42e6"
}

data "aws_alb_target_group" "prd-aip-nftf-unit-detail-tg" {
  arn = "arn:aws:elasticloadbalancing:ap-northeast-2:618467231866:targetgroup/prd-aip-nftf-unit-detail-tg/db910da84ce37e40"
}

data "aws_alb_target_group" "prd-aip-services-event-tg" {
  arn = "arn:aws:elasticloadbalancing:ap-northeast-2:618467231866:targetgroup/prd-aip-services-event-tg/cec2f0036322485b"
}

data "aws_alb_target_group" "prd-aip-services-ingestion-tg" {
  arn = "arn:aws:elasticloadbalancing:ap-northeast-2:618467231866:targetgroup/prd-aip-services-ingestion-tg/0871d406953bab27"
}

data "aws_alb_target_group" "prd-aip-services-insight-tg" {
  arn = "arn:aws:elasticloadbalancing:ap-northeast-2:618467231866:targetgroup/prd-aip-services-insight-tg/ba590ec9befa4284"
}

data "aws_alb_target_group" "prd-aip-services-metric-tg" {
  arn = "arn:aws:elasticloadbalancing:ap-northeast-2:618467231866:targetgroup/prd-aip-services-metric-tg/6a79be12f5ca1ca0"
}

data "aws_iam_role" "prd-com-codedeploy-role" {
  name               = "prd-com-codedeploy-role"
}
