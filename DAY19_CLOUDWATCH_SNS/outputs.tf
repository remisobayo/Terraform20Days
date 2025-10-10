

output "KKE_sns_topic_name" {
    description = "for the SNS topic name."
    value = aws_sns_topic.sns_topic.name
}

output "KKE_cloudwatch_alarm_name" {
    description = "for the CloudWatch alarm name."
    value = aws_cloudwatch_metric_alarm.compute_alarm.alarm_name
    }