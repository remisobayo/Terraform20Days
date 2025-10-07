
variable "KKE_DYNAMODB_TABLE_NAME" {
    description = "Dynamodb table name."
    type = string
    # default = "devops-cf-dynamodb-table"
}


variable "stack_name" {
    description = "CloudFormation Stack Name"
    type = string
    # default = "devops-dynamodb-stack"
}