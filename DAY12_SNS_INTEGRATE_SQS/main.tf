resource "aws_sns_topic" "user_updates" {
  name = var.KKE_SNS_topic_name
}

resource "aws_sqs_queue" "user_updates_queue" {
  name   = var.kke_sqs_queue_name
  # policy = data.aws_iam_policy_document.sqs_queue_policy.json
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.user_updates_queue.arn
}

data "aws_iam_policy_document" "sqs_queue_policy" {
  policy_id = "${aws_sqs_queue.user_updates_queue.arn}/SQSDefaultPolicy"

  statement {
    sid    = "user_updates_sqs_target"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      aws_sqs_queue.user_updates_queue.arn,
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        aws_sns_topic.user_updates.arn,
      ]
    }
  }
}

resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  queue_url = aws_sqs_queue.user_updates_queue.id
  policy    = data.aws_iam_policy_document.sqs_queue_policy.json
}