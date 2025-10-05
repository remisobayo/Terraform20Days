variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "sns_topic_name" {
  description = "Name of the SNS topic"
  type        = string
  default     = "nautilus-sns-topic"
}

variable "encryption_enabled" {
  description = "Check if encryption is enabled"
  type        = bool
  default     = true
}

variable "kms_key_description" {
  description = "Description for the KMS key"
  type        = string
  default     = "KMS key for SNS topic encryption"
}

variable "custom_kms_key_name" {
  description = "Custom KMS key"
  type        = string
  default     = null
}

variable "kms_key_id" {
    description = "KMS Key ID, if existing"
    type = string
    default = null  
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "production"
}