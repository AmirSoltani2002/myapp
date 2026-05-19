# Data source to get VPC info
# data "terraform_remote_state" "vpc" {
#   backend = "local"
#   config = {
#     path = "../terraform.tfstate"
#   }
# }

resource "aws_db_instance" "db" {
  allocated_storage      = var.allocated_storage
  storage_encrypted        = false # Set to false for LocalStack
  # max_allocated_storage  = var.allocated_storage * var.max_allocated_storage_coef # Unsupported in LocalStack
  db_name                = var.db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true # Force to true for LocalStack
  apply_immediately      = true
  multi_az               = false # Set to false for LocalStack
  publicly_accessible    = false
  # vpc_security_group_ids = var.db_security_group_ids # Comment out for LocalStack
  backup_retention_period  = 0 # Enforce 0 for LocalStack to prevent snapshot hangs
  # backup_target            = var.backup_target # Unsupported in LocalStack
  # delete_automated_backups = var.delete_automated_backups # Unsupported in LocalStack
  db_subnet_group_name     = var.db_subnet_group_name # Comment out for LocalStack
}