# create two route table
# one for public subnets
# destination 0.0.0.0/0
# target internet gateway as igw-tf

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.demo.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# create 2nd route table for public and only associate with private subnet
# note we have not assiciated any route to private subnet

resource "aws_route_table" "private" {
    depends_on = [ 
    aws_nat_gateway.nat-gw
   ]
   vpc_id = aws_vpc.demo.id
   route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
   }
   tags = {
    Name = "Route table for NAT gateway"
   }
    
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

