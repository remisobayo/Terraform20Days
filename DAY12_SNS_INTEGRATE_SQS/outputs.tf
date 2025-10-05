

output "kke_sns_topic_arn" {
    value = aws_sns_topic.user_updates.arn
}

output "kke_sqs_queue_url" {
    value = aws_sqs_queue.user_updates_queue.url
}