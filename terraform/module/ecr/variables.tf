variable "app_name" {
  description = "The name of the application, used for naming the ECR repository"
  type        = string
}

variable "ENV" {
  description = "The environment tag for the ECR repository"
  type        = string
  default     = "dev"
}