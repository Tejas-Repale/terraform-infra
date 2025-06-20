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
  }
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "AppServer"
  }
}

# RDS Subnet Group (Final Version )
resource "aws_db_subnet_group" "db_subnet" {
  name = "db-subnet-group"

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
}
