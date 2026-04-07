variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Project name used in tags"
  type        = string
  default     = "assignment3"
}

variable "environment" {
  description = "Environment name used in tags"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Two CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Exactly 2 public subnet CIDRs are required."
  }
}

variable "private_subnet_cidrs" {
  description = "Two CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]

  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Exactly 2 private subnet CIDRs are required."
  }
}

variable "instance_type" {
  description = "EC2 instance type for web and private instances"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "instance_type must be one of: t3.micro, t3.small, t3.medium."
  }
}

variable "ami_id" {
  description = "AMI ID override. Leave empty to use the latest Ubuntu 22.04 LTS AMI from SSM."
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Name of the AWS key pair to create"
  type        = string
  default     = "assignment3-key"
}

variable "my_ip_cidr" {
  description = "Your public IP in CIDR format for SSH access to web server (example: x.x.x.x/32)"
  type        = string
}
