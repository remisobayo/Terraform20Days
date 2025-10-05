output "kke_sns_topic_name" {
  description = "The name of the SNS topic"
  value       = aws_sns_topic.sns_topic.name

}

output "kke_role_name" {
  description = "The name of the role"
  value       = aws_iam_role.sns_role.name
}

output "kke_policy_name" {
  description = "The name of the policy"
  value       = aws_iam_policy.sns_role_policy.name
}

