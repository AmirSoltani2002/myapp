output "lb_security_group_id" {
  value = aws_security_group.lb[*].id
}

output "app_security_group_id" {
  value = aws_security_group.app[*].id
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion[*].id
}

output "db_security_group_id" {
  value = aws_security_group.db[*].id
}

output "bastion_security_group_name" {
  value = aws_security_group.bastion[*].name
}

output "db_security_group_name" {
  value = aws_security_group.db[*].name
}

output "app_security_group_name" {
  value = aws_security_group.app[*].name
}

output "lb_security_group_name" {
  value = aws_security_group.lb[*].name
}