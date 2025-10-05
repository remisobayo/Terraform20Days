
# Specify which services can access the role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = [  "ec2.amazonaws.com",           # EC2 instances
  "lambda.amazonaws.com",        # Lambda functions
  "ecs-tasks.amazonaws.com",     # ECS tasks
  "eks.amazonaws.com",           # EKS clusters
  "appsync.amazonaws.com",       # AppSync
  "apigateway.amazonaws.com",    # API Gateway
  "codedeploy.amazonaws.com",    # CodeDeploy
  "cloudformation.amazonaws.com" # CloudFormation
]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = var.KKE_ROLE_NAME
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# what permissions should the role have
data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:GetItem", "dynamodb:Scan", "dynamodb:Query"]
    resources = [aws_dynamodb_table.basic-dynamodb-table.arn,
          "${aws_dynamodb_table.basic-dynamodb-table.arn}/index/*"]
          #"arn:aws:dynamodb:*:*:table/YOUR_TABLE_NAME/index/*"
  }
#     statement {
#     actions   = ["dynamodb:DescribeTable", "dynamodb:ListTables" ]
#     resources = ["*"]
#     effect = "Allow"
#   }
 
}

# Attach a document to this policy. The doc can be a json file
resource "aws_iam_policy" "policy" {
  name        = var.KKE_POLICY_NAME
  description = "Read-only access to specific DynamoDB table"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}


# Provision DynamoDB table
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.KKE_TABLE_NAME
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"
#   range_key      = "GameTitle"

  attribute {
    name = "id"
    type = "S"
  }
/*
  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }
*/
 
}