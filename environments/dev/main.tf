provider "aws" {
  region = var.region
}

locals {
  common_tags = {
    Environment = var.env
    Project     = "my-project"
    Terraform   = "true"
  }
}


module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr            = var.vpc_cidr
  vpc_azs             = var.vpc_azs
  vpc_public_subnets  = var.vpc_public_subnets
  vpc_private_subnets = var.vpc_private_subnets
  enable_nat_gateway  = var.enable_nat_gateway
  enable_vpn_gateway  = var.enable_vpn_gateway
  tags                = local.common_tags
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
  tags            = local.common_tags


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

// waf
module "waf" {
  source = "../../modules/waf"

  env     = var.env
  tags    = local.common_tags
  alb_arn = module.alb.arn
}

module "ecr" {
  source = "../../modules/ecr"
  tags   = local.common_tags
}

module "security_group" {
  source = "../../modules/security-group"

  env       = var.env
  tags      = local.common_tags
  vpc_id    = module.vpc.vpc_id
  alb_sg_id = module.alb.security_group_id
}

module "ecs" {
  source = "../../modules/ecs"

  cluster_name = var.cluster_name
  tags         = local.common_tags


  services = {
    # React frontend (public subnet)
    react = {
      cpu    = 256
      memory = 512
      container_definitions = {
        react = {
          image         = module.ecr.ecr_react_frontend_url
          port_mappings = [{ containerPort = 80, hostPort = 80, protocol = "tcp" }]
        }
      }
      load_balancer = {
        service = {
          target_group_arn = aws_lb_target_group.frontend.arn
          container_name   = "react"
          container_port   = 80
        }
      }
      subnet_ids = module.vpc.public_subnet_ids
      security_group_rules = {
        alb_ingress_80 = {
          type                     = "ingress"
          from_port                = 80
          to_port                  = 80
          protocol                 = "tcp"
          source_security_group_id = module.alb.security_group_id
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }

    # FastAPI backend (public subnet or internal depending on use)
    fastapi = {
      cpu    = 256
      memory = 512
      container_definitions = {
        fastapi = {
          image         = module.ecr.ecr_fastapi_url
          port_mappings = [{ containerPort = 8000, hostPort = 8000, protocol = "tcp" }]
        }
      }
      load_balancer = {
        service = {
          target_group_arn = aws_lb_target_group.fastapi.arn
          container_name   = "fastapi"
          container_port   = 8000
        }
      }
      subnet_ids = module.vpc.public_subnet_ids
      security_group_ids = [module.security_group.fastapi-sg-id]
    }

    # Celery Worker (private subnet)
    celery_worker = {
      cpu    = 256
      memory = 512
      container_definitions = {
        celery = {
          image = module.ecr.ecr_celery_worker_url
        }
      }
      subnet_ids = module.vpc.private_subnet_ids
    }

    # Celery Beat (private subnet)
    celery_beat = {
      cpu    = 256
      memory = 512
      container_definitions = {
        beat = {
          image       = module.ecr.ecr_celery_beat_url
          environment = [{ name = "ENV", value = var.env }]
        }
      }
      subnet_ids = module.vpc.private_subnet_ids
    }

    # Data Poller (private subnet)
    data_poller = {
      cpu    = 256
      memory = 512
      container_definitions = {
        poller = {
          image = module.ecr.ecr_data_poller_url
        }
      }
      subnet_ids           = module.vpc.private_subnet_ids
      security_group_rules = {}
    }
  }
}


module "cloudwatch" {
  source = "../../modules/cloudwatch"

  env  = var.env
  tags = local.common_tags
}