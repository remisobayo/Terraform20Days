

data "aws_iam_policy_document" "assume_sns_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"] # trusted entity
    }

    actions = ["sts:AssumeRole"]
  }

}

/*
data "aws_iam_policy_document" "role_policy_doc" {
  statement {
    effect    = "Allow"
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.sns_topic.arn]
  }
}
*/


resource "aws_iam_policy" "sns_role_policy" {
  name        = local.KKE_POLICY_NAME
#   path        = "."
#   description = "Role Policy to Publish to SNS Topic"
#   policy      = data.aws_iam_policy_document.role_policy_doc.json
  description = "Allows publishing to the Nautilus SNS topic using an external JSON file."

  # Use templatefile() to read the JSON file and substitute the ARN variable
  policy = templatefile("${path.module}/nautilus-sns-policy.json", {
    topic_arn = aws_sns_topic.sns_topic.arn
  })
}

resource "aws_iam_role" "sns_role" {
  name               = local.KKE_ROLE_NAME
  assume_role_policy = data.aws_iam_policy_document.assume_sns_role.json
}

resource "aws_iam_role_policy_attachment" "attach_role" {
  role       = aws_iam_role.sns_role.name
  policy_arn = aws_iam_policy.sns_role_policy.arn
}

resource "aws_sns_topic" "sns_topic" {
  name = local.KKE_SNS_TOPIC_NAME

}


/* Resource-Based Policy
resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.test.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.account-id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.test.arn,
    ]

    sid = "__default_statement_ID"
  }
}

*/