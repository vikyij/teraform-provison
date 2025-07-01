//fastapi security group
resource "aws_security_group" "ecs_fastapi" {
  name   = "ecs-fastapi-${var.env}"
  description = "Allow ALB to connect to ECS Fastapi"
  vpc_id = var.vpc_id

  ingress {
    from_port      = 8000
    to_port        = 8000
    protocol       = "tcp"
    security_groups = [var.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}


// rds security group
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg-${var.env}"
  description = "Allow ECS to connect to RDS"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Postgres from ECS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_fastapi.id]  # Allow traffic from ECS SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
