resource "aws_cloudformation_stack" "dynamodb" {
  name = var.stack_name
  template_body = local.cf_template_body

  parameters = {
    TableName   = "devops-cf-dynamodb-table"
    BillingMode = "PAY_PER_REQUEST"
  }
  
  capabilities = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM"]
  
  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
  
  tags = {
    Name        = "devops-dynamodb-stack"
    Environment = "production"
    ManagedBy   = "terraform"
  }

  # Lifecycle block to ignore changes to parameters
  lifecycle {
    ignore_changes = [
      parameters  # This will prevent Terraform from detecting parameter changes
    ]
  }
}

