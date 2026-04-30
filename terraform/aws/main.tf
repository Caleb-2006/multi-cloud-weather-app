provider "aws" {
  region = "us-east-1"
}

# -----------------------------
# VPC
# -----------------------------
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP, SSH, and backend ports"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Frontend"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Backend API"
    from_port   = 5002
    to_port     = 5002
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
  }
}

# -----------------------------
# Backend EC2 Instance
# -----------------------------
resource "aws_instance" "backend" {
  ami                         = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = "dhanu1"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install docker -y
              sudo service docker start
              sudo docker pull dhanu/mcw-backend:latest
              sudo docker run -d --restart unless-stopped -p 5002:5000 --env OWM_API_KEY=${var.owm_api_key} dhanu/mcw-backend:latest
              EOF

  tags = {
    Name = "backend-instance"
  }
}

# -----------------------------
# Frontend EC2 Instance
# -----------------------------
resource "aws_instance" "frontend" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = "dhanu1"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install docker -y
              sudo service docker start
              sudo docker pull dhanu/mcw-frontend:latest
              sudo docker run -d --restart unless-stopped -p 80:80 dhanu/mcw-frontend:latest
              EOF

  tags = {
    Name = "frontend-instance"
  }
}

# -----------------------------
# Outputs
# -----------------------------
output "backend_public_ip" {
  value = aws_instance.backend.public_ip
}

output "frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}