variable "vpc_cidr" {
  description = "This is the CIDR of the vpc"
  type        = string
}

variable "vpc_azs" {
  description = "This is the availabily zones"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "This is the public subnets in the vpc"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "This is the private subnets in the vpc"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "This enables/diables nat gateway that's attached to private subnet for internet access"
  type        = string
}

variable "enable_vpn_gateway" {
  description = "This enables/disables vpn gateway"
  type        = string
}

variable "env" {
  description = "defines the different environments"
  type        = string
}

variable "region" {
  description = "This is the aws region where resources will be created"
  type        = string
}

variable "cluster_name" {
  description = "defines the cluster name"
  type        = string
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

variable "secrets_map" {
  type        = map(string)
  description = "Map of secrets to store as key-value JSON"
}