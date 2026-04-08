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

variable "state_lock_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
  default     = "terraform-state-locks"
}

variable "ec2_s3_role_name" {
  description = "IAM role name for EC2 access to the assignment S3 bucket"
  type        = string
  default     = "assignment3-ec2-s3-role"
}

variable "asg_min_size" {
  description = "Minimum number of instances in Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum number of instances in Auto Scaling Group"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in Auto Scaling Group"
  type        = number
  default     = 1
}

variable "scale_out_cpu_threshold" {
  description = "CPU percentage threshold to scale out"
  type        = number
  default     = 60
}

variable "scale_in_cpu_threshold" {
  description = "CPU percentage threshold to scale in"
  type        = number
  default     = 20
}
