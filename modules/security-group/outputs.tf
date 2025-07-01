output "fastapi-sg-id" {
  value = aws_security_group.ecs_fastapi.id
}

output "rds-sg-id" {
  value = aws_security_group.rds_sg.id
}

output "rds-sg-arn" {
  value = aws_security_group.rds_sg.arn
}
