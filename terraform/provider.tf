terraform {
  # Comment this out for local testing to avoid connecting to real AWS
  # backend "s3" { ... }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Version 6.0 is very new; ensure your LocalStack supports it
    }
  }
}

provider "aws" {
  region                      = var.region
  access_key                  = "user"
  secret_key                  = "user"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true # CRITICAL for LocalStack

  endpoints {
    ec2         = var.endpoints
    s3          = var.endpoints
    elb         = var.endpoints
    elbv2       = var.endpoints
    rds         = var.endpoints
    autoscaling = var.endpoints
    ecr         = var.endpoints
    iam         = var.endpoints
    kms         = var.endpoints
    route53     = var.endpoints
    cloudwatch  = var.endpoints
    logs        = var.endpoints
  }
}

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 6.0"
#     }
#   }
# }

# provider "aws" {
#   region = var.region
# }

resource "aws_s3_bucket" "lb_access_logs" {
  bucket = var.access_logs_bucket
}

resource "aws_s3_bucket_policy" "lb_access_logs" {
  bucket     = var.access_logs_bucket
  depends_on = [aws_s3_bucket.lb_access_logs]
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSLoadBalancerLogsPolicy"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::897822967062:root"
        }
        Action = [
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::${var.access_logs_bucket}/*"
      },
      {
        Sid    = "AWSLoadBalancerLogsGetBucketAcl"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::897822967062:root"
        }
        Action   = "s3:GetBucketAcl"
        Resource = "arn:aws:s3:::${var.access_logs_bucket}"
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "lb_access_logs" {
  bucket                  = var.access_logs_bucket
  depends_on              = [aws_s3_bucket.lb_access_logs]
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "lb_access_logs" {
  bucket     = var.access_logs_bucket
  depends_on = [aws_s3_bucket.lb_access_logs]
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# resource "aws_s3_bucket" "lb-backup" {
#   bucket = "${var.access_logs_bucket}-backup"
# }

# resource "aws_s3_bucket_ownership_controls" "lb-backup" {
#   bucket = aws_s3_bucket.lb-backup.id
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
#   depends_on = [aws_s3_bucket.lb-backup]
# }

# resource "aws_s3_bucket_acl" "lb-backup" {
#   depends_on = [aws_s3_bucket_ownership_controls.lb-backup]

#   bucket = aws_s3_bucket.lb-backup.id
#   acl    = "private" # or "public-read"
# }
