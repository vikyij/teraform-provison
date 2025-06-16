# ECS module using official terraform-aws-modules/ecs/aws
module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "5.12.1"

  # Name of the ECS cluster to create or use
  cluster_name = var.cluster_name

  # Enable ECS Exec for remote debugging into running containers
  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/${var.cluster_name}"
      }
    }
  }

  # Use both FARGATE and FARGATE_SPOT to balance cost and availability
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  # Define all ECS services (e.g., react, fastapi, celery) in one map
  services = var.services

  # Tags for organization and cost tracking
  tags = var.tags
}
