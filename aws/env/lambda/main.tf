provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "develop-infra-core"
    key     = "terraform/lambda/state/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  default     = "my-lambda-function"
}

variable "lambda_handler" {
  description = "Name of the Lambda handler function"
  default     = "lambda_handler"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  default     = "develop-infra-core"
}

variable "s3_object_key" {
  description = "Key for the S3 object"
  default     = "lambda/lambda_function.zip"
}

variable "schedule_enabled" {
  description = "schedule enabler"
  default     = true
}

variable "schedule_exp" {
  description = "expression"
  default     = "rate(1 minute)"
}

variable "log_level" {
  description = "log level"
  default     = "DEBUG"
}

variable "max_notifications" {
  description = "value"
  default     = "1000"
}

variable "thread_count" {
  description = "value"
  default     = "10"
}

resource "aws_lambda_function" "my_lambda_function" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = var.lambda_handler
  runtime          = "python3.9"
  s3_bucket        = var.s3_bucket_name
  s3_key           = var.s3_object_key
  source_code_hash = base64sha256(filebase64("${path.module}/lambda_function.zip"))
  timeout          = 60

  environment {
    variables = {
      LOG_LEVEL            = var.log_level
      MAX_NOTIFICATIONS    = var.max_notifications
      THREAD_COUNT         = var.thread_count
      SCHEDULE_ENABLED     = var.schedule_enabled
      SCHEDULE_EXPRESSION = var.schedule_exp
    }
  }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/lambda/${aws_lambda_function.my_lambda_function.function_name}"
  retention_in_days = 30
}

# Create security group
resource "aws_security_group" "lambda_sg" {
  name        = "lambda-security-group"
  description = "Security group for the Lambda function"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["127.0.0.1/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["127.0.0.1/32"]
  }
}

# Create IAM role for Lambda execution
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_s3_bucket_object" "lambda_function_archive" {
  bucket = var.s3_bucket_name
  key    = var.s3_object_key
  source = "lambda_function.zip"
  etag   = filemd5("lambda_function.zip")
}