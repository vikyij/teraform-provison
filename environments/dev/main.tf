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

// retrieve existing acm certificate
data "aws_acm_certificate" "existing_cert" {
  domain      = "victoriaudechukwu.com"
  statuses    = ["ISSUED"]
  most_recent = true
}


module "alb" {
  source = "../../modules/alb"

  name            = "${var.env}-alb"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnet_ids
  certificate_arn = data.aws_acm_certificate.existing_cert.arn
  env             = var.env

  depends_on = [module.vpc]
}

 resource "aws_lb_target_group" "frontend" {
   name        = "frontend"
   port        = 80
   protocol    = "HTTP"
   target_type = "ip"
   vpc_id      = module.vpc.vpc_id

  health_check {
     path = "/"
   }
 }

 resource "aws_lb_target_group" "fastapi" {
   name        = "fastapi"
   port        = 8000
   protocol    = "HTTP"
   target_type = "ip"
   vpc_id      = module.vpc.vpc_id

   health_check {
     path = "/health"
   }
}

// define alb listener rules for frontend - this routes traffic requests from / to the frontend ecs
resource "aws_lb_listener_rule" "frontend" {
  listener_arn = module.alb.listener_arns["https"].arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn

  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

# // define alb listener rules for fastapi - this routes traffic requests from /api to the fastapi ecs

resource "aws_lb_listener_rule" "fastapi_api" {
  listener_arn = module.alb.listener_arns["https"].arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fastapi.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}