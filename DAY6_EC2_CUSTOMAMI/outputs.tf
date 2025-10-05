

output "KKE_ami_id" {
    description = "the AMI ID created"
    value = aws_ami_from_instance.dev-ami.id
}

output "KKE_new_instance_id" {
    description = "ID for the new EC2 instance."
    value = aws_instance.ami-ec2.id
}