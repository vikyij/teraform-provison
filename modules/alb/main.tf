
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.16.0"

  name               = var.name
  vpc_id             = var.vpc_id
  subnets            = var.subnets


  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  security_group_egress_rules = {
    all_outbound = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all outbound"
    }
  }

  listeners = {
     http = {
      port            = 80
      protocol        = "HTTP"
       default_action_type = "fixed-response"
    fixed_response = {
      content_type = "text/plain"
      message_body = "404 - Not found"
      status_code  = "404"
    }
    }
    https = {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = var.certificate_arn
    default_action_type = "fixed-response"
    fixed_response = {
      content_type = "text/plain"
      message_body = "404 - Not found"
      status_code  = "404"
    }
    }
  }
  
  #   tags = {
  #   Environment = var.env
  #   Project= "my-project"
  # }
  tags = var.tags
}
