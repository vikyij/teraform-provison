# ECS cluster name
variable "cluster_name" {
    description = "defines the cluster name"
    type = string
}

variable "env" {
    description = "defines the different environments"
    type = string
}

variable "services" {
  description = "Defines all ECS services (e.g., react, fastapi, celery)"
  type = any
}