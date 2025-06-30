output "log_group_arn" {
  value = aws_cloudwatch_log_group.ecs_logs.arn
}

output "metric_arn" {
  value = aws_cloudwatch_metric_alarm.high_cpu.arn
}

