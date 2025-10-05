


resource "aws_kinesis_stream" "datacenter_stream" {
  name             = "datacenter-kinesis-stream"
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "IncomingRecords",
    "OutgoingBytes",
    "OutgoingRecords",
    "WriteProvisionedThroughputExceeded",
    "ReadProvisionedThroughputExceeded",
    "IteratorAgeMilliseconds",
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

#   tags = {
#     Environment = "Dev"
#   }
}


resource "aws_cloudwatch_metric_alarm" "kinesis_stream_alarm" {
  alarm_name                = "datacenter-kinesis-alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 2
  metric_name               = "WriteProvisionedThroughputExceeded"
  namespace                 = "AWS/Kinesis"
  period                    = 60
  statistic                 = "Sum" # "Average"
  threshold                 = 1
  alarm_description         = "This metric monitors write provisioned throughput exceeded"
  insufficient_data_actions = []
  
  dimensions = {
    StreamName = aws_kinesis_stream.datacenter_stream.name
  }

  alarm_actions = [aws_sns_topic.kinesis_alerts.arn] # Link to SNS topic for alerting
  ok_actions    = [aws_sns_topic.kinesis_alerts.arn]
}




resource "aws_sns_topic" "kinesis_alerts" {
  name = "KinesisAlertsTopic"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.kinesis_alerts.arn
  protocol  = "email"
  endpoint  = "remisobayo@yahoo.com" # Replace with your email address
}