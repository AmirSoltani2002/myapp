variable "name" {
  description = "The name of the load balancer and target group."
  type        = string
}

variable "app_port" {
  description = "The port on which the load balancer will forward traffic to the target group."
  type        = number
  default     = 8088
}

variable "front_port" {
  description = "The port on which the load balancer will listen for incoming traffic."
  type        = number
  default     = 80
}

variable "protocol" {
  description = "The protocol for the load balancer and target group."
  type        = string
  default     = "HTTP"
}

variable "access_logs_bucket" {
  description = "The S3 bucket for storing access logs."
  type        = string
  default     = ""
}

variable "log_prifix" {
  description = "The prefix for the access logs in the S3 bucket."
  type        = string
  default     = "db-access-logs/"
}

variable "enable_access_logs" {
  description = "Enable access logs for the load balancer."
  type        = bool
  default     = true
}

variable "ENV" {
  description = "The environment tag for the load balancer."
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "The ID of the VPC where the load balancer will be created."
  type        = string
  default     = ""
}

variable "lb_security_group_ids" {
  description = "The security group IDs to associate with the load balancer."
  type        = list(string)
  default     = []
}

variable "lb_subnet_ids" {
  description = "The subnet IDs to associate with the load balancer."
  type        = list(string)
  default     = []
}
