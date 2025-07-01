variable "env" {
  type        = string
  description = "defines the different environments"
}

variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
}

variable "vpc_id" {
  type        = string
  description = "defines the vpc id"
}

variable "alb_sg_id" {
  type = string
  description = "defines alb sg"
}