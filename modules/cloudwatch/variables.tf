variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
}

variable "env" {
  type        = string
  description = "defines the different environments"
}