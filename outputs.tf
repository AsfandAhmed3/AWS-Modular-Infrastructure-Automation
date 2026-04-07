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
