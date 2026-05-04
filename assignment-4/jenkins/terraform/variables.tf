variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Project name used in tags"
  type        = string
  default     = "assignment4"
}

variable "environment" {
  description = "Environment name used in tags"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "VPC ID from Assignment 3"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for Jenkins controller"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for Jenkins agent"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your public IP in CIDR format for SSH and Jenkins UI"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
  default     = "assignment4-jenkins-key"
}

variable "instance_type_controller" {
  description = "Controller instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_type_agent" {
  description = "Agent instance type"
  type        = string
  default     = "t3.micro"
}
