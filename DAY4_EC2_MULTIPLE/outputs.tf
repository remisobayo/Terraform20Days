


output "kke_instance_names" {
    description = "The name of the ec2 instances"
    value = aws_instance.web_server[*].tags.Name
    # value = aws_instance.web_server[count.index].tags.Name

}

# output "kke_instance_names" {
#   value = [for instance in aws_instance.web_server : instance.tags.Name]
# }