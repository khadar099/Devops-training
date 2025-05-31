provider "aws" {
  region = "us-east-1" # Change as needed
}

# Create a security group
resource "aws_security_group" "instance_sg" {
  name        = "ec2_sg"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH access - adjust in production
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # HTTP access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}

# List of instance names
locals {
  instance_names = ["webserver", "devserver", "sitserver"]
}

# Create EC2 instances
resource "aws_instance" "ec2_instances" {
  count         = length(local.instance_names)
  ami           = "ami-0e35ddab05955cf57"
  instance_type = "t2.micro"
  key_name      = "key-pair2" # Replace with your actual key pair name

  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = local.instance_names[count.index]
  }
}
