# 1️⃣ Security Group (top or bottom anywhere outside)
resource "aws_security_group" "ssh" {
  name = "allow-ssh"

  ingress {
    from_port   = 22
    to_port     = 22
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

# 2️⃣ EC2 resource
resource "aws_instance" "web" {
  count         = 2
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
  key_name      = data.aws_key_pair.existing.key_name

  subnet_id = data.aws_subnets.default.ids[0]

  # attach security group here 👇
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = {
    Name = "ansible-ec2-${count.index}"
  }
}
