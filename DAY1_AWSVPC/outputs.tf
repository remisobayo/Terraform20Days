
output "kke_vpc_name" {
   description = "The name of the main VPC."
   value       = aws_vpc.main.tags.Name
}

output "kke_subnet_name" {
    description = "The name of the subnet."
    value = aws_subnet.public.tags.Name
   
}