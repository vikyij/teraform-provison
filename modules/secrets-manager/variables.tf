variable "env" {
  type        = string
  description = "defines the different environments"
}

variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
}

variable "secrets_map" {
  type        = map(string)
  description = "Map of secrets to store as key-value JSON"
}