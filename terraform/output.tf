# output "lb_dns_name" {
#   description = "The DNS name of the load balancer"
#   value       = module.lb.dns_name
# }

# output "lb_target_group_arn" {
#   description = "The ARN of the load balancer target group"
#   value       = module.lb.target_group_arn
# }

# output "db_dns_name" {
#   description = "The DNS name of the RDS instance"
#   value       = module.db.db_dns_name
# }

# output "autoscaling_group_id" {
#   description = "The ID of the Auto Scaling group"
#   value       = module.asg.id
# }

output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.ecr_repository_url
}

output "db_address" {
  description = "The address of the RDS instance"
  value       = module.db.db_address
}
