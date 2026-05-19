output "db_dns_name" {
  description = "The DNS name of the RDS instance"
  value       = aws_db_instance.db.endpoint
}

output "db_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.db.address
}
