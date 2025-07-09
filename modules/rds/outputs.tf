output "rds_endpoint" {
  description = "MySQL RDS endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "rds_instance_id" {
  description = "RDS instance ID"
  value       = aws_db_instance.mysql.id
}
