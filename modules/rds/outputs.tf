output "rds_endpoint" {
  description = "MySQL RDS endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "rds_instance_id" {
  description = "RDS instance ID"
  value       = aws_db_instance.mysql.id
}

output "rds_address" {
  description = "RDS hostname only (without port)"
  value       = aws_db_instance.mysql.address
}

output "rds_port" {
  description = "RDS port number"
  value       = aws_db_instance.mysql.port
}