
# fetch the latest Amazon Linux 2 AMI.
data "aws_ami" "amazon_linux_2_latest" {
  most_recent = true

  filter {
    name   = "name"
    # values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Matches the common naming convention for AL2 AMIs
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

#   owners = ["099720109477"] # Canonical
  owners = ["amazon"]
}

