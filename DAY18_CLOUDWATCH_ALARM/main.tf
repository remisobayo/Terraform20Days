
data "aws_sns_topic" "topic" {
    name = var.sns_topic_name
}

/*
resource "aws_sns_topic" "sns_topic" {
  name = "devops-sns-topic"
}
*/

# EC2 instance
resource "aws_instance" "ec2" {
#   name = var.instance_name
  ami = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
  
}

# CloudWatch alarm
resource "aws_cloudwatch_metric_alarm" "compute_alarm" {
  alarm_name                = var.alarm_name
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 90
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
  actions_enabled     = "true"
  alarm_actions       = [data.aws_sns_topic.topic.arn]
  ok_actions          = [data.aws_sns_topic.topic.arn]

  dimensions = {
    InstanceId = aws_instance.ec2.id  # "i-abc123" 
      }
}