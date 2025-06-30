//cloudwatch log group
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.env}-app"
  retention_in_days = 30

  tags = var.tags
}

//cloudwatch alarm
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name                = "high-cpu-${var.env}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ecs cpu utilization"
  insufficient_data_actions = []

  tags = var.tags
}

