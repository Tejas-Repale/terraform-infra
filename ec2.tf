<<<<<<< HEAD
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
=======
resource "aws_instance" "web_server" {
  ami           = "ami-0c768662cc797cd75"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id] # ✅ correct for VPC
>>>>>>> 99ecdeff4d07acd3ddf2a8aff16cf8a7680eee25

  tags = {
    Name = "WebServer"
  }
}
