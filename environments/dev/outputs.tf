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
  value = module.iam.task-execution_role-arn
}

output "task-role-arn" {
    description = "This is the task role arn"
  value = module.iam.task-role-arn
}