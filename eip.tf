# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.demo]
  tags = {
    Name = "NAT Gateway EIP"
  }
}