output "vpc_id" {
  description = "displays the vpcs id"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "List of private subnet IDs"
}

output "task-execution_role-arn" {
  description = "This is the task execution role arn"
  value       = module.iam.task-execution_role-arn
}

output "task-role-arn" {
  description = "This is the task role arn"
  value       = module.iam.task-role-arn
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "security_group_id" {
  value = module.alb.security_group_id
}

output "frontend_target_group_arn" {
  value = aws_lb_target_group.frontend.arn
}

output "fastapi_target_group_arn" {
  value = aws_lb_target_group.fastapi.arn
}


output "listener_arns" {
  value = module.alb.listener_arns
}

output "target_group_arns" {
  value = module.alb.target_group_arns
}

output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}

output "ecr_react_frontend_url" {
  value = module.ecr.ecr_react_frontend_url
}

output "ecr_fastapi_api_url" {
  value = module.ecr.ecr_fastapi_url
}

output "ecr_celery_worker_url" {
  value = module.ecr.ecr_celery_worker_url
}

output "ecr_celery_beat_url" {
  value = module.ecr.ecr_celery_beat_url
}

output "ecr_data_poller_url" {
  value = module.ecr.ecr_data_poller_url
}

output "arn" {
  value = module.alb.arn
}

output "web_acl_arn" {
  value       = module.waf.web_acl_arn
  description = "WAF Web ACL ARN"
}

output "log_group_arn" {
  value = module.cloudwatch.log_group_arn
}

output "metric_arn" {
  value = module.cloudwatch.metric_arn
}

output "fastapi_sg_id" {
  description = "Security group ID for FastAPI service"
  value       = module.security_group.fastapi-sg-id
}

output "rds_sg_id" {
  value = module.security_group.rds-sg-id
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_address" {
  value = module.rds.rds_address
}

output "rds_port" {
  value = module.rds.rds_port
}

output "rds_instance_id" {
  value = module.rds.rds_instance_id
}

output "secret_id" {
  value = module.secrets.secret_id
}

output "secret_arn" {
  value = module.secrets.secret_arn
}

output "secret_name" {
  value = module.secrets.secret_name
}
