cat > README.md <<'EOF'
# Terraform EC2 Project

This project provisions:
- 1 Security Group
- 2 EC2 Instances
- Uses existing default VPC and subnets
- Uses existing AWS key pair

## Files
- provider.tf
- variables.tf
- terraform.tfvars
- data.tf
- main.tf
- outputs.tf
- backend.tf

## Commands
```bash
terraform init
terraform validate
terraform plan
terraform apply
