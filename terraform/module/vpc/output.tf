output "public_ip_id" {
  value = aws_subnet.public[*].id
}

output "private_ip_id" {
  value = aws_subnet.private[*].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_group_db_name" {
  value = aws_db_subnet_group.db.name
}