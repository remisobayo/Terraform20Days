# Output the table ARN and name
output "kke_dynamodb_table" {
  description = "name of the DynamoDB table"
  value       = aws_dynamodb_table.basic-dynamodb-table.name
}

output "kke_iam_role_name" {
  description = "name of the IAM role"
  value       = aws_iam_role.role.name
}

output "kke_iam_policy_name" {
  description = "name of the IAM policy"
  value       = aws_iam_policy.policy.name
}