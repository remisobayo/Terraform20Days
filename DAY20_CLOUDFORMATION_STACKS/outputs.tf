output "KKE_stack_name" {
    description = "CloudFormation stack name"
    value = aws_cloudformation_stack.dynamodb.name
}
