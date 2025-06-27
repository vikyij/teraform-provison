output "alb_dns_name" {
  value = module.alb.dns_name
}

output "security_group_id" {
  value = module.alb.security_group_id
}

output "frontend_target_group_arn" {
  value = module.alb.target_groups
}

output "fastapi_target_group_arn" {
  value = module.alb.target_groups
}

output "listener_arns" {
  value = module.alb.listeners
}

output "target_group_arns" {
  value = module.alb.target_groups
}

output "arn" {
  value = module.alb.arn
}

