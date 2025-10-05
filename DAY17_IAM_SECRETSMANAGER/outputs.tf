 output "KKE_secret_name" {
    description = "The secret name"
    value = aws_secretsmanager_secret.app_secrets.name
    }



output "KKE_role_name" {
    description= "The IAM role name"
    value = aws_iam_role.secrets_role.name
    }


output "KKE_policy_name" {
    description = "The IAM policy name"
    value = aws_iam_role_policy.secrets_role_policy.name
    }