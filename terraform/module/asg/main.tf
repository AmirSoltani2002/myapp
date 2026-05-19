resource "aws_launch_template" "app" {
  name_prefix            = var.name_prefix
  image_id               = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  tags = {
    ENV = var.ENV
  }
  #security_group_names = [aws_security_group.app.id, aws_security_group.bastion.id]
}

resource "aws_autoscaling_group" "app" {
  name                = "my-app-asg-test" # Hardcode a name to be safe
  max_size            = var.max_size
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.zone_identifiers

  launch_template {
    id      = aws_launch_template.app.id
    version = "1" # Use $Latest instead of $Default just in case
  }

  # 🛑 COMMENT ALL OF THIS OUT FOR NOW:
  target_group_arns   = [var.target_group_arn]
  health_check_type   = "ELB"
  force_delete        = true
  
  # 🛑 ALSO COMMENT OUT ANY TAG BLOCKS
  # dynamic "tag" { ... }
  # tags = { ... }
}


//mock asg
# resource "aws_instance" "this" {
#   count = 2
#   ami           = "ami-df5de72bdb3b" # Use LocalStack's built-in default AMI ID
#   instance_type = "t3.micro"
#   tenancy       = "default"          # Changed from "host" to avoid host-allocation failures
#   subnet_id     = var.subnet_ids[0] # Just pick the first subnet for testing
#   security_groups = var.security_group_ids
#   tags = {
#     Name = "ASG Test Instance"
#     ENV  = var.ENV
#   }
#   user_data_base64 = base64encode(<<-EOF
#     #!/bin/bash
#     echo "Infrastructure is working" > index.html
#     python3 -m http.server 8088 &
#   EOF
#   )
# }

# resource "aws_lb_target_group_attachment" "web_attach" {
#   count            = 2
#   target_group_arn = var.target_group_arn
#   target_id        = aws_instance.this[count.index].id
#   port             = 8088
# }