
module "sns" {
    source = "../DAY0_SNS_ENCRYPTION"

    sns_topic_name = "nautilus-sns-test"
    custom_kms_key_name = "nautilus-sns-key"

}


output "sns_topic_arn" {
  description = "ARN of the encrypted SNS topic"
  value       = module.sns.sns_topic_arn
}

output "sns_topic_name" {
  description = "Name of the encrypted SNS topic"
  value       = module.sns.sns_topic_name
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for encryption"
  value       = module.sns.kms_key_arn
}

output "kms_key_id" {
  description = "ID of the KMS key used for encryption"
  value       = module.sns.kms_key_id
}