<<<<<<< HEAD
# Provider
provider "aws" {
  region = "ap-south-1"

  default_tags {
    tags = {
      Project   = var.project_name
      Owner     = var.owner
      ManagedBy = "Terraform"
    }
  }
}

# Get Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# EC2 Instances
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "WebServer"
=======
# main.tf
provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
>>>>>>> 99ecdeff4d07acd3ddf2a8aff16cf8a7680eee25
  }
}

resource "aws_instance" "app_server" {
<<<<<<< HEAD
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnet_1.id
=======
  ami                    = "ami-0c768662cc797cd75"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
>>>>>>> 99ecdeff4d07acd3ddf2a8aff16cf8a7680eee25
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "AppServer"
  }
}

<<<<<<< HEAD
# RDS Subnet Group (Final Version ✅)
resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet-group"

  # Must have subnets across 2 Availability Zones
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  tags = {
    Name = "DBSubnetGroup"
  }
}

# RDS Instance
resource "aws_db_instance" "mydb" {
  identifier             = "mydb"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "password123"
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name = "MyRDSInstance"
  }
}

terraform {
  required_version = ">= 1.12.0, < 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.0"
    }
  }
=======
output "app_server_ip" {
  value = aws_instance.app_server.private_ip
>>>>>>> 99ecdeff4d07acd3ddf2a8aff16cf8a7680eee25
}
