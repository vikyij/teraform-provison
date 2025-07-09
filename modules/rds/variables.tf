variable "env" {
  type        = string
  description = "defines the different environments"
}

variable "private_subnets" {
  type        = list(string)
  description = "an array of private subnets"
}

variable "db_name" {
  type        = string
  description = "name of the database"
}

variable "db_username" {
  type        = string
  description = "database username for login"
}

variable "db_password" {
  type        = string
  description = "database password for login"
}

variable "db_instance" {
  type        = string
  description = "name of the RDS instance"
}

variable "rds_security_group_id" {
  type        = string
  description = "RDS security group id"
}

variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
}