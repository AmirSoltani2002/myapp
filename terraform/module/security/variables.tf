variable "lb_front_port" {
  description = "The port on which the load balancer will listen for incoming traffic."
  type        = number
  default     = 80
}

variable "protocol" {
  description = "The protocol for the load balancer and target group."
  type        = string
  default     = "tcp"
}

variable "lb_ingress_allowed_cidr_blocks" {
  description = "The CIDR blocks allowed for ingress traffic to the load balancer."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "lb_egress_allowed_cidr_blocks" {
  description = "The CIDR blocks allowed for egress traffic from the load balancer."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_egress_allowed_cidr_blocks" {
  description = "The CIDR blocks allowed for egress traffic from the application security group."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_ingress_allowed_security_groups" {
  description = "The security group IDs allowed for ingress traffic to the application security group."
  type        = list(string)
  default     = []
}

variable "bastion_ingress_allowed_cidr_blocks" {
  description = "The CIDR blocks allowed for ingress traffic to the bastion security group."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "bastion_egress_allowed_cidr_blocks" {
  description = "The CIDR blocks allowed for egress traffic from the bastion security group."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "db_ingress_allowed_security_groups" {
  description = "The security group IDs allowed for ingress traffic to the database security group."
  type        = list(string)
  default     = []
}

variable "db_ingress_allowed_cidr_blocks" {
  description = "The CIDR blocks allowed for ingress traffic to the database security group."
  type        = list(string)
  default     = []
}

variable "db_egress_allowed_security_groups" {
  description = "The security group IDs allowed for egress traffic from the database security group."
  type        = list(string)
  default     = []
}

variable "app_front_port" {
  description = "The port on which the application will listen for incoming traffic from the load balancer."
  type        = number
  default     = 8088
}

variable "ENV" {
  description = "The environment tag for the security groups."
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created."
  type        = string
  default     = ""
}

variable "app_security_group_ids" {
  description = "The security group IDs to associate with the application security group."
  type        = list(string)
  default     = []
}

variable "db_front_port" {
  description = "The port on which the database will listen for incoming traffic from the application."
  type        = number
  default     = 3306
}