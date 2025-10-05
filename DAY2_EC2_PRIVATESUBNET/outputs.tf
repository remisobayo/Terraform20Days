
output "KKE_vpc_name" {
   description = "The name of the main VPC."
   value       = aws_vpc.main.tags.Name
}

output "KKE_subnet_name" {
    description = "The name of the subnet."
    value = aws_subnet.main.tags.Name
   
}

output "KKE_ec2_private" {
    description = "The name of the ec2 instance."
    value = aws_instance.web.tags.Name
   
}