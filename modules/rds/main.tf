
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "mysql-subnetgroup-${var.env}"
  subnet_ids = var.private_subnets

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage      = 10
  db_name                = var.db_name
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  identifier             = var.db_instance
  vpc_security_group_ids = [var.rds_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  skip_final_snapshot    = true
  multi_az               = false

  tags = var.tags
}