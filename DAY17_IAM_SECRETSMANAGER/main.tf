
data "aws_iam_policy_document" "assume_secrets_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"] # trusted entity
    }

    actions = ["sts:AssumeRole"]
  }

}

/*
data "aws_iam_policy_document" "role_policy_doc" {
  statement {
    effect    = "Allow"
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.sns_topic.arn]
  }
}
*/

# 1. Data Block to define the IAM Policy Document
# This document grants 'secretsmanager:GetSecretValue' permission.
data "aws_iam_policy_document" "nautilus_app_secret_access" {
  statement {
    sid = "SecretsManagerRetrieve"

    actions = [
      "secretsmanager:GetSecretValue",
      # Include KMS Decrypt permission if your secret uses a customer-managed KMS key (not the default 'aws/secretsmanager' key)
      "kms:Decrypt" 
    ]

    effect = "Allow"

    resources = [
      # ⚠️ IMPORTANT: Replace this with the ARN of your specific secret
      # Example format: "arn:aws:secretsmanager:us-east-1:123456789012:secret:my-app-secret-abcdef"
      aws_secretsmanager_secret.app_secrets.arn,
      # ⚠️ IMPORTANT: If using KMS: Replace this with the ARN of your KMS key
      # var.kms_key_arn 
    ]
  }
}

resource "aws_iam_role" "secrets_role" {
  name               = var.KKE_ROLE_NAME
  assume_role_policy = data.aws_iam_policy_document.assume_secrets_role.json
}


resource "aws_iam_role_policy" "secrets_role_policy" {
  name        = var.KKE_POLICY_NAME
  role = aws_iam_role.secrets_role.id
 
  policy = data.aws_iam_policy_document.nautilus_app_secret_access.json 
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         sid = "SecretsManagerRetrieve"
#         Action = [
#           "secretsmanager:GetSecretValue",
#           "kms:Decrypt"
#         ]
#         Effect   = "Allow"
#         Resource = [aws_secretsmanager_secret.app_secrets.arn]
#       },
#     ]
#   })
  
}

# resource "aws_iam_role_policy_attachment" "attach_role" {
#   role       = aws_iam_role.secrets_role.name
#   policy_arn = aws_iam_policy.secrets_role_policy.arn
# }

resource "aws_secretsmanager_secret" "app_secrets" {
  name = var.KKE_SECRET_NAME
  description = "Application credentials for the Nautilus application."
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "app_secret_version" {
  secret_id     = aws_secretsmanager_secret.app_secrets.id
  secret_string = var.KKE_SECRET_VALUE
}







