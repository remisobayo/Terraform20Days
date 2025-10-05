

# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-964cfdf3d08f8a319"
  ]

  tags = {
    Name = "devops-ec2"
  }
}


resource "aws_ami_from_instance" "dev-ami" {
  name               = "devops-ec2-ami"
  source_instance_id = aws_instance.ec2.id  # "i-xxxxxxxx"
}


resource "aws_instance" "ami-ec2" {
  ami           = aws_ami_from_instance.dev-ami.id
  # instance_type = var.instance_type

  tags = {
    Name = "devops-ec2-new"
  }
}