

output "KKE_instance_name" {
    value = aws_instance.app.tags.Name

}

output "KKE_eip" {
    value = aws_eip.my_eip.public_ip
}