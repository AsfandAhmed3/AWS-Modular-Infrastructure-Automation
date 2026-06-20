output "controller_public_ip" {
  description = "Public IP of Jenkins controller"
  value       = aws_instance.jenkins_controller.public_ip
}

output "agent_private_ip" {
  description = "Private IP of Jenkins agent"
  value       = aws_instance.jenkins_agent.private_ip
}

output "jenkins_key_file" {
  description = "Local path to generated SSH private key"
  value       = local_sensitive_file.jenkins_private_key.filename
}

output "controller_sg_id" {
  description = "Security group ID for Jenkins controller"
  value       = aws_security_group.jenkins_controller.id
}

output "agent_sg_id" {
  description = "Security group ID for Jenkins agent"
  value       = aws_security_group.jenkins_agent.id
}
