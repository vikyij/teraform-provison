# ECS cluster name
variable "cluster_name" {
  description = "defines the cluster name"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
}

variable "services" {
  description = "Defines all ECS services (e.g., react, fastapi, celery)"
  type        = any
}