
#EC2 instance named - xfusion-ec2 (Ubuntu AMI)
/*
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
*/

resource "aws_instance" "app" {
  # ami           = data.aws_ami.ubuntu.id
  ami = "ami-01b2110eef525172b"
  instance_type = var.instance_type

  tags = {
    Name = "xfusion-ec2"
  }
}


# Elastic IP resource
resource "aws_eip" "my_eip" {
  instance = aws_instance.app.id
  domain   = "vpc"

   tags = {
    Name = "xfusion-eip"
  }
}

/*
resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.app.id
  allocation_id = aws_eip.my_eip.id
}
*/