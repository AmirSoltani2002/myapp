module "db" {
  source                     = "./module/db"
  allocated_storage          = var.allocated_storage
  db_name                    = var.db_name
  db_password                = var.db_password
  db_security_group_ids      = module.security.db_security_group_id
  db_subnet_group_name       = module.vpc.subnet_group_db_name
  db_username                = var.db_username
  engine                     = var.engine
  engine_version             = var.engine_version
  ENV                        = var.ENV
  instance_class             = var.instance_class
  max_allocated_storage_coef = var.max_allocated_storage_coef
}

# module "lb" {
#   source                = "./module/lb"
#   name                  = var.lb_name
#   app_port              = var.app_front_port
#   front_port            = var.lb_front_port
#   protocol              = var.protocol_lb
#   access_logs_bucket    = var.access_logs_bucket
#   log_prifix            = var.log_prifix
#   enable_access_logs    = var.enable_access_logs
#   vpc_id                = module.vpc.vpc_id
#   lb_security_group_ids = module.security.lb_security_group_id
#   lb_subnet_ids         = module.vpc.public_ip_id
#   ENV                   = var.ENV
#   depends_on = [
#     aws_s3_bucket_policy.lb_access_logs,
#     aws_s3_bucket_public_access_block.lb_access_logs,
#     aws_s3_bucket_ownership_controls.lb_access_logs
#   ]
# }

module "security" {
  source                              = "./module/security"
  lb_front_port                       = var.lb_front_port
  protocol                            = var.protocol_security
  lb_ingress_allowed_cidr_blocks      = var.lb_ingress_allowed_cidr_blocks
  lb_egress_allowed_cidr_blocks       = var.lb_egress_allowed_cidr_blocks
  app_egress_allowed_cidr_blocks      = var.app_egress_allowed_cidr_blocks
  app_ingress_allowed_security_groups = module.security.lb_security_group_id
  bastion_ingress_allowed_cidr_blocks = var.bastion_ingress_allowed_cidr_blocks
  bastion_egress_allowed_cidr_blocks  = var.bastion_egress_allowed_cidr_blocks
  db_ingress_allowed_security_groups  = module.security.app_security_group_id
  db_egress_allowed_security_groups   = module.security.app_security_group_id
  app_front_port                      = var.app_front_port
  ENV                                 = var.ENV
  vpc_id                              = module.vpc.vpc_id
  db_ingress_allowed_cidr_blocks      = var.db_ingress_allowed_cidr_blocks
}

module "vpc" {
  source             = "./module/vpc"
  ENV                = var.ENV
  availability_zones = var.availability_zones
  region             = var.region
  cidr_block         = var.vpc_cidr_block
  cidr_public        = var.vpc_cidr_public
  cidr_private       = var.vpc_cidr_private
}

module "ecr" {
  source   = "./module/ecr"
  app_name = var.app_name
  ENV      = var.ENV
}

# module "asg" {
#   source             = "./module/asg"
#   name_prefix        = var.asg_name_prefix
#   image_id           = var.image_id
#   desired_capacity   = var.asg_desired_capacity
#   max_size           = var.asg_max_size
#   min_size           = var.asg_min_size
#   ENV                = var.ENV
#   instance_type      = var.instance_type
#   security_group_ids = concat(module.security.app_security_group_id, module.security.bastion_security_group_id)
#   zone_identifiers   = module.vpc.private_ip_id
#   target_group_arn   = module.lb.target_group_arn
#   depends_on = [
#     module.lb,
#     module.security
#   ]
#   lb_arn     = module.lb.lb_arn
#   subnet_ids = module.vpc.private_ip_id
# }

