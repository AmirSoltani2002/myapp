# provider "aws" {
#   region                      = var.region
#   access_key                  = "test"
#   secret_key                  = "test"
#   skip_credentials_validation = true
#   skip_metadata_api_check     = true
#   skip_requesting_account_id  = true

#   endpoints {
#     # Point the specific services you are using to your local container
#     # s3             = "http://localhost:4566"
#     # ec2            = "http://localhost:4566"
#     # iam            = "http://localhost:4566"
#     # lambda         = "http://localhost:4566"
#     # To cover everything at once, use: 
#     endpoints = "http://localhost:4566"
#   }
# }