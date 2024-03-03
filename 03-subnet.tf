
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.demo.id
  cidr_block = var.public-cidr
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.public-subnet
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.demo.id
  cidr_block = var.private-cidr
  availability_zone = var.az
  tags = {
    Name = var.private-subnet
  }
}

