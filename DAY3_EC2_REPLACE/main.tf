resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}




# CLI commands

# bob@iac-server ~/terraform via 💠 default ➜  history
#     1  terraform show
#     2  pwd
#     3  terraform plan
#     6  terraform plan -replace
#     7  terraform apply -help

#    12  terraform state list
#    13  terraform show
#    14  terraform apply -replace="aws_instance.webserver"
#    18  terraform plan -replace="aws_instance.webserver.instance_id"
#    19  terraform plan -replace="aws_instance.web_server"
#    20  terraform apply -replace="aws_instance.web_server"
#    21  history