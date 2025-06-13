variable "env" {
  description = "defines the different environments"
  type = string
}

variable "task_policy_json" {
  description = "IAM policy JSON for ECS task role"
  type = string
}