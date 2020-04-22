terraform {
  required_version = "~> 0.12.20"
  backend "local" {}
}

provider "aws" {
  profile = "wjtb"
  shared_credentials_file = "~/.aws/credentials"
  region = "ap-northeast-2"
  version = "~> 2.51"
}

module "aip-vpc" {
  source = "./modules/aip-vpc"

  # import data
  prd-aip-vpc_id = var.prd-aip-vpc_id
}


module "code-deploy" {
  source = "./services/code-deploy"
  prd-aip-ami_id = var.prd-aip-ami_id

  # vpc
  aip-vpc_id = module.aip-vpc.id

}
