output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "nat_gateway_id" {
  description = "ID of NAT Gateway"
  value       = aws_nat_gateway.main.id
}

output "web_security_group_id" {
  description = "ID of web server security group"
  value       = aws_security_group.web.id
}

output "db_security_group_id" {
  description = "ID of database security group"
  value       = aws_security_group.db.id
}

output "web_instance_id" {
  description = "ID of public web EC2 instance"
  value       = aws_instance.web.id
}

output "web_instance_public_ip" {
  description = "Public IP of web EC2 instance"
  value       = aws_instance.web.public_ip
}

output "private_instance_id" {
  description = "ID of private EC2 instance"
  value       = aws_instance.private_db.id
}

output "private_instance_private_ip" {
  description = "Private IP of private EC2 instance"
  value       = aws_instance.private_db.private_ip
}

output "ssh_private_key_file" {
  description = "Local path to generated private key"
  value       = local_sensitive_file.ec2_private_key.filename
}

output "tf_state_bucket_name" {
  description = "S3 bucket name used for Terraform state"
  value       = aws_s3_bucket.state.bucket
}

output "tf_state_lock_table" {
  description = "DynamoDB table name used for Terraform state locking"
  value       = aws_dynamodb_table.state_lock.name
}

output "ec2_s3_role_name" {
  description = "IAM role name for EC2 S3 access"
  value       = aws_iam_role.ec2_s3_access.name
}

output "asg_name" {
  description = "Name of the web Auto Scaling Group"
  value       = aws_autoscaling_group.web.name
}

output "launch_template_id" {
  description = "Launch template ID used by ASG"
  value       = aws_launch_template.web_asg.id
}

output "cpu_high_alarm_name" {
  description = "CloudWatch alarm for scale-out"
  value       = aws_cloudwatch_metric_alarm.cpu_high.alarm_name
}

output "cpu_low_alarm_name" {
  description = "CloudWatch alarm for scale-in"
  value       = aws_cloudwatch_metric_alarm.cpu_low.alarm_name
}
