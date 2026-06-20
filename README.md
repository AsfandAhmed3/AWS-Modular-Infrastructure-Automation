# AWS Modular Infrastructure Automation

AWS Modular Infrastructure Automation is the Terraform foundation for this repository. It provisions a secure, reusable AWS network and compute layer that can be inspected, extended, and destroyed cleanly from code.

## Why This Project Exists

The stack demonstrates how to build a modular cloud baseline with Terraform instead of manual console work. It is designed to show strong infrastructure habits: clear naming, reusable inputs, remote state, locking, controlled access, and separation between public and private workloads.

## What The Stack Creates

The current Terraform configuration builds the following AWS resources:

- A custom VPC with CIDR `10.0.0.0/16`
- DNS support and DNS hostnames enabled
- Two public subnets across separate Availability Zones
- Two private subnets across separate Availability Zones
- An Internet Gateway attached to the VPC
- A public route table associated with the public subnets
- An Elastic IP and NAT Gateway for outbound private subnet internet access
- A private route table associated with the private subnets
- A generated SSH key pair and local private key file for EC2 access
- Security groups for the ALB, public web server, and private database server
- EC2 instances for the public application server and private database server
- An S3 bucket for Terraform state with versioning, AES-256 encryption, and public access blocking
- A DynamoDB table for Terraform state locking
- An IAM role and instance profile for EC2 access to the S3 bucket
- An Auto Scaling Group with CloudWatch alarms
- An Application Load Balancer and target group for traffic distribution

## Architecture Snapshot

Traffic flows from the Internet Gateway into the public route table. Public instances can reach the internet directly, while private instances use the NAT Gateway for outbound-only access. That keeps internal systems off the internet while still letting them update packages, pull dependencies, and reach external services when needed.

## Repository Layout

- `backend.tf` - remote state backend configuration
- `main.tf` - core AWS resources for networking, security, compute, state, scaling, and load balancing
- `outputs.tf` - exported IDs, names, IP addresses, and resource references
- `provider.tf` - AWS provider setup
- `variables.tf` - input variables, defaults, and validation rules
- `terraform.tfvars` - environment-specific values such as CIDRs, IP allow lists, and instance settings
- `tfplan`, `tfplan-task4`, `tfplan-task5` - saved binary plans used during the workflow

## Key Inputs

The Terraform code is parameterized so it can be reused safely and adapted without changing the resource definitions.

- `aws_region` - AWS region, default `eu-north-1`
- `project_name` - name prefix used in tags and resource names
- `environment` - environment label used in names and tags
- `vpc_cidr` - VPC CIDR block
- `public_subnet_cidrs` - exactly two public subnet CIDRs
- `private_subnet_cidrs` - exactly two private subnet CIDRs
- `instance_type` - EC2 size, validated to `t3.micro`, `t3.small`, or `t3.medium`
- `ami_id` - optional AMI override, otherwise the latest Ubuntu 22.04 AMI is used from SSM
- `key_name` - name of the Terraform-created AWS key pair
- `my_ip_cidr` - your public IP in CIDR form for SSH access
- `state_lock_table_name` - DynamoDB lock table name
- `ec2_s3_role_name` - IAM role name for EC2 bucket access
- `asg_min_size`, `asg_max_size`, `asg_desired_capacity` - Auto Scaling Group sizing
- `scale_out_cpu_threshold`, `scale_in_cpu_threshold` - CloudWatch alarm thresholds

## Useful Commands

```powershell
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform state list
terraform output
terraform destroy
```

## Outputs

The `outputs.tf` file exposes values that are useful for verification and for later delivery work.

- `vpc_id`
- `public_subnet_ids`
- `private_subnet_ids`
- `nat_gateway_id`
- `web_security_group_id`
- `db_security_group_id`
- `web_instance_id`
- `web_instance_public_ip`
- `private_instance_id`
- `private_instance_private_ip`
- `ssh_private_key_file`
- `tf_state_bucket_name`
- `tf_state_lock_table`
- `ec2_s3_role_name`
- `asg_name`
- `launch_template_id`
- `cpu_high_alarm_name`
- `cpu_low_alarm_name`
- `alb_dns_name`
- `alb_security_group_id`
- `target_group_arn`

## Report Evidence

For documentation or presentation purposes, capture the following outputs and screenshots:

- `terraform plan` before deployment
- `terraform apply` after deployment
- `terraform state list` showing created resources
- VPC and subnet layout in the AWS Console
- Route tables showing public and private routes
- NAT Gateway and Internet Gateway details
- Security group rules for the EC2 and ALB resources
- EC2 instance details, public IPs, and private IPs
- S3 bucket versioning, encryption, and public access block settings
- DynamoDB state lock table
- CloudWatch alarms and Auto Scaling activity history
- ALB target group and listener details
- `terraform destroy` proving the stack is removed cleanly

## Notes

- The NAT Gateway explicitly depends on the Internet Gateway using `depends_on`.
- `terraform.tfvars` should be used to set the instance and CIDR values for your environment.
- The stack is intentionally reusable so the Cloud Delivery Platform folder can build on top of it without recreating infrastructure manually.
