output "sns_topic_arn" {
  description = "ARN of the encrypted SNS topic"
  value       = aws_sns_topic.encrypted_topic.arn
}

output "sns_topic_name" {
  description = "Name of the encrypted SNS topic"
  value       = aws_sns_topic.encrypted_topic.name
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for encryption"
  value       = aws_kms_key.sns_encryption_key[0].arn
}

output "kms_key_id" {
  description = "ID of the KMS key used for encryption"
  value       = aws_kms_key.sns_encryption_key[0].key_id
}