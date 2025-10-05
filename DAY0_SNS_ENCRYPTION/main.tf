terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# KMS Key for SNS encryption
resource "aws_kms_key" "sns_encryption_key" {
  count = var.encryption_enabled && var.kms_key_id == null ? 1 : 0
  description             = var.kms_key_description
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = jsonencode({
    Id = "sns-key-policy"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
      {
        Action = [
          "kms:GenerateDataKey",
          "kms:Decrypt"
        ]
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Resource = "*"
        Sid      = "Allow SNS to use the key"
      }
    ]
    Version = "2012-10-17"
  })

  tags = {
    Name        = "sns-encryption-key"
    Environment = "production"
  }
}

# KMS Key Alias
resource "aws_kms_alias" "sns_encryption_key_alias" {
  count = var.encryption_enabled && var.kms_key_id == null && var.custom_kms_key_name != null ? 1 : 0
  name          = "alias/${var.custom_kms_key_name}"
  target_key_id = aws_kms_key.sns_encryption_key[0].key_id
}

# SNS Topic with encryption enabled
resource "aws_sns_topic" "encrypted_topic" {
  name              = var.sns_topic_name
#   display_name      = "Encrypted SNS Topic"
  # kms_master_key_id = aws_kms_key.sns_encryption_key.arn
  # kms_master_key_id = var.encryption_enabled ? (var.kms_key_id != null ? var.kms_key_id : coalesce(aws_kms_alias.sns_encryption_key_alias[0].id, aws_kms_key.sns_encryption_key[0].id)) : null
  kms_master_key_id = var.encryption_enabled ? (var.kms_key_id != null ? var.kms_key_id : aws_kms_key.sns_encryption_key[0].id) : null
  # Optional: Enable delivery status logging
#   application_success_feedback_role_arn    = aws_iam_role.sns_feedback_role.arn
#   application_success_feedback_sample_rate = 100
#   application_failure_feedback_role_arn    = aws_iam_role.sns_feedback_role.arn

  tags = {
    Name        = "encrypted-sns-topic"
    Environment = "production"
  }
}

/*
# IAM Role for SNS delivery status logging (optional)
resource "aws_iam_role" "sns_feedback_role" {
  name = "sns-feedback-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "sns_feedback_policy" {
  name = "sns-feedback-policy"
  role = aws_iam_role.sns_feedback_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:PutMetricFilter",
          "logs:PutRetentionPolicy"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

*/

/*
# SNS Topic Subscription Example (optional)
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.encrypted_topic.arn
  protocol  = "email"
  endpoint  = "remisobayo@yahoo.com" # Replace with your email
}
*/