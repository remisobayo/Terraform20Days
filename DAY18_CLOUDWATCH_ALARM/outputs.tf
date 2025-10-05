
output "KKE_instance_name" {
    description = "for the EC2 instance name."
    value = aws_instance.ec2.tags.Name
} 

output "KKE_alarm_name" {
    description = "for the CloudWatch alarm name."
    value = aws_cloudwatch_metric_alarm.compute_alarm.alarm_name
    
}