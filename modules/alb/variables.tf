variable "name" {
    type = string
    description = "Name of ALB"
}

variable "vpc_id" {
  type = string
  description = "VPC ID for the ALB"
}

variable "subnets" {
   description = "Public subnet IDs"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  type        = string
}

variable "env" {
  description = "defines the different environments"
  type = string
}