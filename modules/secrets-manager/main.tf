resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "rds-credentials-${var.env}"
  description = "this stores rds username and password"
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode(var.secrets_map)
}