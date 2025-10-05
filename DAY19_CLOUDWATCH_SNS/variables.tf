variable "instance_name" {
    type = string
    default = "devops-ec2"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "alarm_name" {
    type = string
    default = "datacenter-cpu-alarm"
}

variable "sns_topic_name" {
    type = string
    default = "datacenter-sns-topic"
}