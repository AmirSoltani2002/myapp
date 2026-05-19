variable "name_prefix" {
  description = "The prefix for the launch template name."
  type        = string
}

variable "image_id" {
  type        = string
  default     = ""
  description = "The AMI ID for the launch template."
}

variable "instance_type" {
  type        = string
  default     = ""
  description = "The instance type for the launch template."
}

# variable availability_zone {
#   type        = list(string)
#   default     = [""]
#   description = "The availability zones for the auto scaling group."
# }

variable "desired_capacity" {
  type        = number
  default     = 2
  description = "The desired capacity for the auto scaling group."
}

variable "max_size" {
  type        = number
  default     = 5
  description = "The maximum size for the auto scaling group."
}

variable "min_size" {
  type        = number
  default     = 2
  description = "The minimum size for the auto scaling group."
}

variable "ENV" {
  type        = string
  default     = "dev"
  description = "The environment tag."
}


variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "The security group IDs for the launch template."
}

variable "zone_identifiers" {
  type        = list(string)
  default     = []
  description = "The subnet IDs for the auto scaling group."
}

variable "target_group_arn" {
  type        = string
  default     = ""
  description = "The ARN of the target group to attach to the auto scaling group."
}

# variable vpc_subnet_ids {
#     type = list(string)
#     description = "VPC subnet IDs for the auto scaling group."
# }

variable "lb_arn" {
  type        = string
  default     = ""
  description = "The ARN of the load balancer to attach to the auto scaling group."
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "The subnet IDs for the test instance."
}

