resource "aws_vpc" "demo" {

  cidr_block = var.vpc-cidr
  tags = {
    Name = var.vpc
  }
}