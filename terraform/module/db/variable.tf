variable "allocated_storage" {
  description = "The allocated storage in gigabytes."
  type        = number
  default     = 10
}

variable "max_allocated_storage_coef" {
  description = "The maximum allocated storage coef"
  type        = number
  default     = 1.5
}

variable "db_name" {
  description = "The name of the database to create."
  type        = string
  default     = "mydb"
}

variable "engine" {
  description = "The database engine to use."
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The version of the database engine."
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "The instance class for the database instance."
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "The master username for the database instance."
  type        = string
  default     = "foo"
}

variable "db_password" {
  description = "The master password for the database instance."
  type        = string
  default     = "foo"
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the database instance."
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for the database instance."
  type        = number
  default     = 1
}

variable "delete_automated_backups" {
  description = "Whether to delete automated backups when deleting the database instance."
  type        = bool
  default     = true
}

variable "backup_target" {
  description = "The target for database instance backups. Valid values are 'region' and 'outpost'."
  type        = string
  default     = "region"
}

variable "ENV" {
  description = "The environment to deploy the database instance in."
  type        = string
  default     = "dev"
}

variable "db_security_group_ids" {
  description = "The security group IDs to associate with the database instance."
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group to associate with the database instance."
  type        = string
  default     = ""
}