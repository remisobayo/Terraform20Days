
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"] # Specifies that the AMI must be owned by Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Filters for Amazon Linux 2 AMIs
  }

  filter {
    name   = "architecture"
    values = ["x86_64"] # Filters for 64-bit architecture
  }
}

# data "aws_ami" "amazon_linux" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }
# }

locals {
  AMI_ID = data.aws_ami.amazon_linux_2.id
}