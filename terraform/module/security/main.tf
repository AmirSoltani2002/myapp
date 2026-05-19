# 1. Base Security Groups (No cross-referencing inline rules)

resource "aws_security_group" "app" {
    name        = "app_sg"
    description = "Security group for app server"
    vpc_id      = var.vpc_id
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "db" {
  name        = "db_sg"
  description = "Allow DataBase inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id
  tags = {
    ENV = var.ENV
  }
}

resource "aws_security_group" "lb" {
  name        = "lb_sg"
  description = "Security group for Load Balancer"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = var.lb_front_port
    to_port     = var.lb_front_port
    protocol    = "tcp"
    cidr_blocks = var.lb_ingress_allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group" "eice_sg" {
#   name        = "eice_sg"
#   description = "Security group for EICE host"
#   vpc_id      = var.vpc_id
#   egress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = var.eice_allowed_cidrs
#   }
# }

resource "aws_security_group" "bastion" {
  name        = "bastion_sg_2"
  description = "Security group for Bastion host"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion_ingress_allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Standalone Ingress Rules to avoid the cycle

# Jenkins Ingress
resource "aws_security_group_rule" "app_from_lb" {
  depends_on = [aws_security_group.app, aws_security_group.lb]
  type                     = "ingress"
  from_port                = var.app_front_port
  to_port                  = var.app_front_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app.id
  source_security_group_id = aws_security_group.lb.id
}

# resource "aws_security_group_rule" "db_from_app" {
#   depends_on = [aws_security_group.db, aws_security_group.app]
#   type                     = "ingress"
#   from_port                = var.db_front_port
#   to_port                  = var.db_front_port
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.db.id
#   source_security_group_id = aws_security_group.app.id
# }

resource "aws_security_group_rule" "db_from_outside" {
  depends_on = [aws_security_group.db]
  type                     = "ingress"
  from_port                = var.db_front_port
  to_port                  = var.db_front_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db.id
  cidr_blocks              = var.db_ingress_allowed_cidr_blocks
}

# resource "aws_security_group_rule" "db_to_app" {
#   type                     = "egress"
#   from_port                = var.app_front_port
#   to_port                  = var.app_front_port
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.db.id
#   destination_security_group_id = aws_security_group.app.id
# }




# resource "aws_security_group_rule" "jenkins_from_eice" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.jenkins_sg.id
#   source_security_group_id = aws_security_group.eice_sg.id
# }

# resource "aws_security_group_rule" "sonarqube_from_eice" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.sonarqube_sg.id
#   source_security_group_id = aws_security_group.eice_sg.id
# }

# resource "aws_security_group_rule" "nexus_from_eice" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.nexus_sg.id
#   source_security_group_id = aws_security_group.eice_sg.id
# }


