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
