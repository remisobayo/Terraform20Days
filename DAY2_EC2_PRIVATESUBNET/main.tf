
# Create VPC
resource "aws_vpc" "main" {
  cidr_block       = var.KKE_VPC_CIDR
  # instance_tenancy = "default"

  tags = {
    Name = "xfusion-priv-vpc"
  }
}

# Private Subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.KKE_SUBNET_CIDR
  # map_public_ip_on_launch = false

  tags = {
    Name = "xfusion-priv-subnet"
  }
}

# EC2 instance
# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }

resource "aws_instance" "web" {
  ami           = "ami-0abcdef1234567890"  # data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
#   vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = false 
  tags = {
    Name = "xfusion-priv-ec2"
  }
}



# Security Group
    resource "aws_security_group" "ec2_sg" {
      vpc_id = aws_vpc.main.id
      name   = "ec2-private-sg"
      description = "Allow inbound SSH"

    #   ingress {
    #     from_port   = 22
    #     to_port     = 22
    #     protocol    = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"] # Restrict this to your specific IP for security
    #   }

    #   egress {
    #     from_port   = 0
    #     to_port     = 0
    #     protocol    = "-1"
    #     cidr_blocks = ["0.0.0.0/0"]
    #   }
    }

    resource "aws_security_group_rule" "allow_vpc_access" {
      type              = "ingress"
      from_port         = 0  # Or specific port, e.g., 22 for SSH
      to_port           = 65535 # Or specific port, e.g., 22 for SSH
      protocol          = "tcp" # Or "all" or specific protocol
      cidr_blocks       = [aws_vpc.main.cidr_block]
      security_group_id = aws_security_group.ec2_sg.id
      description       = "Allow all traffic from within the VPC"
    }

#     cidr_blocks = [aws_vpc.main.cidr_block]: This is the crucial part. It restricts the source of the allowed traffic to only the CIDR block of your aws_vpc.main resource, effectively allowing access only from within your VPC.
# security_group_id = aws_security_group.ec2_sg.id: Associates this rule with the ec2_sg security group.