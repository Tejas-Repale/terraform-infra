resource "aws_instance" "web_server" {
  ami           = "ami-0c768662cc797cd75"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id] # ✅ correct for VPC

  tags = {
    Name = "WebServer"
  }
}
