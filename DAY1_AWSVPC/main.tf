
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

    tags = {
    Name = var.KKE_VPC_NAME
  }

}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = var.KKE_SUBNET_NAME
  }

    # Explicitly declare dependency on the VPC resource
  depends_on = [
    aws_vpc.main
  ]
}