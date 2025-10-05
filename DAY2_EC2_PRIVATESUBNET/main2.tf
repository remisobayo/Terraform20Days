

    resource "aws_vpc" "main" {
      cidr_block = "10.0.0.0/16"
      tags = {
        Name = "my-private-vpc"
      }
    }


    resource "aws_subnet" "private" {
      vpc_id     = aws_vpc.main.id
      cidr_block = "10.0.1.0/24"
      availability_zone = "us-east-1a" # Or your desired AZ
      tags = {
        Name = "my-private-subnet"
      }
    }


    resource "aws_security_group" "ec2_sg" {
      vpc_id = aws_vpc.main.id
      name   = "ec2-private-sg"
      description = "Allow inbound SSH"

      ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Restrict this to your specific IP for security
      }

      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }

    resource "aws_instance" "private_ec2" {
      ami           = "ami-0abcdef1234567890" # Replace with your desired AMI ID
      instance_type = "t2.micro"
      subnet_id     = aws_subnet.private.id
      vpc_security_group_ids = [aws_security_group.ec2_sg.id]
      associate_public_ip_address = false # Crucial for a private instance

      tags = {
        Name = "my-private-ec2-instance"
      }
    }