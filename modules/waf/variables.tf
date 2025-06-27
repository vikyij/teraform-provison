variable "env" {
  type = string
  description = "defines the different environments"
}

variable "tags" {
  type = map(string)
  description = "Common tags for all resources"
}

variable "alb_arn" {
  type = string
  description = "ALB arn"
}