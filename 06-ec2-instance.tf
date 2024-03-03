# create a public EC2 instance 
# assgin assign demo vpc created, public subnet, 
# public IP enabled, key pair, 
# security group to be tagged is aws_security_group.publi that i have created
# t2.micro instance type
# us-east-1 region
# ubuntu free tier image
# startup script with apache2 installed


resource "aws_instance" "public_ec2" {
ami = var.ami
instance_type = var.instance_type
key_name = var.key_name
user_data = "${file(var.startup_script)}"
tags = {
 Name = "public_ec2"
}
vpc_security_group_ids = ["${aws_security_group.public.id}"]
subnet_id = aws_subnet.public.id
associate_public_ip_address = true
}

output "public_ec2_public_ip" {
value = "${aws_instance.public_ec2.public_ip}"
}

resource "aws_instance" "private_ec2" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  user_data = "${file(var.startup_script)}"
  tags = {
    Name = "private_ec2"
  }
  vpc_security_group_ids = ["${aws_security_group.private.id}"]
  subnet_id = aws_subnet.private.id
  associate_public_ip_address = false
}

output "private_ec2_private_ip" {
value = "${aws_instance.private_ec2.private_ip}"
}

