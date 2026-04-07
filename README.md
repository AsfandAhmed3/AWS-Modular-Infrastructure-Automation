# AWS Modular Infrastructure Automation

This repository contains Terraform code for Assignment 3.

## Task 1 Scope
- Custom VPC with DNS support and DNS hostnames
- 2 public subnets in different AZs
- 2 private subnets in different AZs
- Internet Gateway
- Public route table and associations
- NAT Gateway with Elastic IP
- Private route table routing internet traffic through NAT
- Required output values for VPC, subnets, and NAT Gateway

## Commands
```powershell
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform state list
terraform destroy
```

## Notes
- Region is set to `eu-north-1`.
- NAT Gateway explicitly depends on Internet Gateway using `depends_on`.
