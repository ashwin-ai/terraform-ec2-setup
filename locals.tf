#cat > locals.tf <<'EOF'
locals {
  selected_instance_type = var.environment == "prod" ? "t3.medium" : var.instance_type

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

