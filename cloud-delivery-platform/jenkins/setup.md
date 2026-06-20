# Jenkins Controller and Agent Setup

## Controller (public subnet)
1. Provision controller EC2 with Terraform in jenkins/terraform.
2. Open port 8080 to your IP only and port 22 for SSH.
3. User data installs Java 17, Git, Docker, AWS CLI, Terraform, and Jenkins LTS.
4. Complete Jenkins setup wizard and install required plugins from plugins.txt.

## Agent (private subnet)
1. Provision agent EC2 with Terraform in jenkins/terraform.
2. Agent runs in private subnet; allow SSH only from controller security group.
3. Connect agent to controller using SSH and label it linux-agent.

## Required Jenkins Credentials (global)
- aws-keys
- github-pat
- sonarqube-token
- ecr-credentials
- slack-webhook

## GitHub Integration
1. Configure GitHub plugin with PAT.
2. Create Multibranch Pipeline for repo.
3. Add GitHub webhook for automatic builds.
