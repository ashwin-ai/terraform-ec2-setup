# variables.tf 
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS key pair name"
  type        = string
  default     = "new-terraform"
}

variable "sg_name" {
  description = "Security group name"
  type        = string
  default     = "allow-ssh"
}

variable "ingress_ports" {
  description = "List of ingress ports to allow"
  type        = list(number)
  default     = [22, 80]
}

variable "project_name" {
  description = "Project name used in tags"
  type        = string
  default     = "terraform-ec2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

