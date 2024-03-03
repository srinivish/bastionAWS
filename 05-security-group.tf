# Create two security groups , one for public and one for private
# public security group will allow inboud traffic on 22, 80 and 8080
# public security group is tagged to bastion host which is externally accessible
# public security group allows all outgoing access

# private security group will allow inboud traffic on port 22 & 80
# private security group is private-ec2 on private subnet which is not accessible from outside
# private security group allows all outgoing access through the subnet is protected and accessible through NAT
# With respect to private security group, whatever inbound and outbout access needs to be configured


resource "aws_security_group" "public" {
  name = var.sg-public
  vpc_id = aws_vpc.demo.id
  description = "Allow all inbound traffic"
 ingress {
    from_port =80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow http 8080 port"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
   }
   egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
   }

  tags = {
     Name  = var.sg-public
   }
}

resource "aws_security_group" "private" {
  name = var.sg-private
  vpc_id = aws_vpc.demo.id
  description = "Allow inbound traffic within VPC - port 22 and port 80"
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [aws_subnet.public.cidr_block]
    ipv6_cidr_blocks = []  # Empty list for IPv6 (not used)
    prefix_list_ids = []  # Empty list for prefix lists (not used)
    security_groups = []  # Empty list for security groups (not used)
    self = false         # Explicitly set self to false (not required)
    description = ""     # Empty string for description (not required)
   }
   
   ingress {
    from_port =80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   } 
    
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
   }
}