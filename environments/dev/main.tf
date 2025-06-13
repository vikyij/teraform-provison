provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr            = var.vpc_cidr
  vpc_azs             = var.vpc_azs
  vpc_public_subnets  = var.vpc_public_subnets
  vpc_private_subnets = var.vpc_private_subnets
  enable_nat_gateway  = var.enable_nat_gateway
  enable_vpn_gateway  = var.enable_vpn_gateway
  env                 = var.env
}

module "iam" {
  source = "../../modules/iam"

  env              = var.env
  task_policy_json = file("${path.module}/custom_task_policy.json")
}