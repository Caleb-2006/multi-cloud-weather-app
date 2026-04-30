resource "aws_instance" "jenkins" {
  ami                    = "ami-08c40ec9ead489470" # Amazon Linux 2 (update to region)
  instance_type          = "t3.micro"
  key_name               = "dhanu1"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  tags = {
    Name = "jenkins-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install java-openjdk11 -y
              wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
              yum install jenkins git docker -y
              systemctl enable jenkins
              systemctl start jenkins
              systemctl enable docker
              systemctl start docker
              usermod -aG docker jenkins
              usermod -aG docker ec2-user
              EOF
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow Jenkins and SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}