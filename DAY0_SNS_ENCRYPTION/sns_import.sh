#!/bin/bash

# Replace these with your actual resource names/IDs
SNS_TOPIC_ARN="arn:aws:sns:us-east-1:123456789012:your-topic-name"
KMS_KEY_ID="alias/your-kms-key-alias" # or the key ID
LAMBDA_FUNCTION_NAME="your-lambda-function-name"

# Import SNS Topic
terraform import aws_sns_topic.encrypted_topic "$SNS_TOPIC_ARN"

# Import KMS Key (if using alias, you might need to get the key ID first)
# terraform import aws_kms_key.sns_key "$KMS_KEY_ID"

# Import Lambda Function
terraform import aws_lambda_function.subscriber_lambda "$LAMBDA_FUNCTION_NAME"