variable "ENV" {
  description = "ENV variable"
  default     = "dev"
  type        = string
}

variable "availability_zones" {
  description = "The availability zone for the VPC and subnets."
  type        = list(string)
}

variable "region" {
  description = "The AWS region where the VPC will be created."
  type        = string
  default     = "us-east-1"
}

variable "cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "latency" {
  description = "Latency for the auto scaling group."
  type        = string
  default     = "default"
}

variable "enable_dns_support" {
  description = "Enable DNS support for the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for the VPC."
  type        = bool
  default     = true
}

variable "cidr_public" {
  description = "CIDR block for the public subnet."
  type        = list(string)
}

variable "cidr_private" {
  description = "CIDR blocks for the private subnets."
  type        = list(string)
}
