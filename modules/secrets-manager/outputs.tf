output "secret_id" {
  value = aws_secretsmanager_secret.db_credentials.id
}

output "secret_arn" {
  value = aws_secretsmanager_secret.db_credentials.arn
}

output "secret_name" {
  value = aws_secretsmanager_secret.db_credentials.name
}