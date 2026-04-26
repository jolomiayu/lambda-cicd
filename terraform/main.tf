terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"   # lighter version (fixes your space issue)
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

# S3 Bucket
resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "lambda-artifacts-jolomi-tf-001"
}

# Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name = "terraformLambda"

  role = "arn:aws:iam::825765402564:role/service-role/cicdLambda-role-ahyzqgmj"

  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"

  filename = "function.zip"
}
