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