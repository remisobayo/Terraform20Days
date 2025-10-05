
output "kke_kinesis_stream_name" {
    description = "name for the Kinesis stream name."
    value = aws_kinesis_stream.datacenter_stream.name
}


output "kke_kinesis_alarm_name" {
    description = "kke_kinesis_alarm_name for the CloudWatch alarm name."
    value = aws_cloudwatch_metric_alarm.kinesis_stream_alarm.alarm_name

}