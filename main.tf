terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# 1️⃣ Get latest Ubuntu AMI
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 2️⃣ Get existing key pair
data "aws_key_pair" "existing" {
  key_name = "your-key-name"
}

# 3️⃣ Get default VPC
data "aws_vpc" "default" {
  default = true
}

# 4️⃣ Get default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# 5️⃣ Security Group for SSH
resource "aws_security_group" "ssh" {
  name        = "allow-ssh"
  description = "Allow SSH access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh-sg"
  }
}

# 6️⃣ EC2 Instances
resource "aws_instance" "web" {
  count         = 2
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
  key_name      = data.aws_key_pair.existing.key_name

  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = {
    Name = "ansible-ec2-${count.index + 1}"
  }
}
