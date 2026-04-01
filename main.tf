#cat > main.tf <<'EOF'
resource "aws_security_group" "ssh" {
  name        = var.sg_name
  description = "Allow required ports"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.ingress_ports

    content {
      description = "Allow port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = var.sg_name
  })
}

resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = local.selected_instance_type
  key_name      = data.aws_key_pair.existing.key_name

  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = merge(local.common_tags, {
    Name = "ansible-ec2-${count.index + 1}"
  })
}

