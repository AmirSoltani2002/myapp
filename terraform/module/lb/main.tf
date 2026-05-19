resource "aws_lb_target_group" "app" {
  name     = var.name
  port     = var.app_port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  tags = {
    ENV = var.ENV
  }
}


resource "aws_lb" "lb" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  # security_groups    = [aws_security_group.lb.id]
  # subnets            = [aws_subnet.public.*.id]
  security_groups            = var.lb_security_group_ids
  subnets                    = var.lb_subnet_ids
  enable_deletion_protection = false

  access_logs {
    bucket  = var.access_logs_bucket
    prefix  = var.log_prifix
    enabled = var.enable_access_logs
  }

  connection_logs {
    bucket  = var.access_logs_bucket
    prefix  = "${var.log_prifix}_connection-logs/"
    enabled = var.enable_access_logs
  }

  tags = {
    ENV = var.ENV
  }
}

resource "aws_lb_listener" "front" {
  load_balancer_arn = aws_lb.lb.arn # ← references your ALB
  port              = var.front_port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn # ← points to the pool
  }
}
