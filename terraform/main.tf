terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-jolomi"
    key            = "global/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
  }
}

provider "aws" {
  region = "eu-west-1"
}

# Environment variable
variable "env" {
  default = "dev"
}

# S3 bucket for artifacts
resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "lambda-artifacts-jolomi-${var.env}"
}

# Lambda function
resource "aws_lambda_function" "my_lambda" {
  function_name = "terraformLambda-${var.env}"

  role = "arn:aws:iam::825765402564:role/service-role/cicdLambda-role-ahyzqgmj"

  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"

  filename = "function.zip"
}
