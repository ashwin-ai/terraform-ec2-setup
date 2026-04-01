#cat > outputs.tf <<'EOF'
output "instance_ids" {
  description = "EC2 instance IDs"
  value       = aws_instance.web[*].id
}

output "public_ips" {
  description = "EC2 public IPs"
  value       = aws_instance.web[*].public_ip
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.ssh.id
}

