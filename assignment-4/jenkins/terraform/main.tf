data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "tls_private_key" "jenkins_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "jenkins_private_key" {
  content         = tls_private_key.jenkins_key.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0400"
}
terraform {
  backend "s3" {
    bucket         = "your-unique-terraform-state-bucket"
    key            = "assignment-4/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}
resource "aws_key_pair" "jenkins_key" {
  key_name   = var.key_name
  public_key = tls_private_key.jenkins_key.public_key_openssh
}

resource "aws_security_group" "jenkins_controller" {
  name        = "${var.project_name}-${var.environment}-jenkins-sg"
  description = "Jenkins controller SG"
  vpc_id      = var.vpc_id

  ingress {
    description = "Jenkins UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-jenkins-sg"
  })
}

resource "aws_security_group" "jenkins_agent" {
  name        = "${var.project_name}-${var.environment}-agent-sg"
  description = "Jenkins agent SG"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from controller"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_controller.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-agent-sg"
  })
}

resource "aws_instance" "jenkins_controller" {
  ami                         = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type               = var.instance_type_controller
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.jenkins_controller.id]
  key_name                    = aws_key_pair.jenkins_key.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail
    apt-get update -y
    apt-get install -y fontconfig openjdk-17-jre git docker.io curl unzip
    systemctl enable docker
    systemctl start docker

    # Install AWS CLI v2
    curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
    unzip -q /tmp/awscliv2.zip -d /tmp
    /tmp/aws/install

    # Install Terraform
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
    apt-get update -y
    apt-get install -y terraform

    # Install Jenkins LTS
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list
    apt-get update -y
    apt-get install -y jenkins
    systemctl enable jenkins
    systemctl start jenkins
  EOF

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-jenkins-controller"
  })
}

resource "aws_instance" "jenkins_agent" {
  ami                    = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type          = var.instance_type_agent
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins_agent.id]
  key_name               = aws_key_pair.jenkins_key.key_name

  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail
    apt-get update -y
    apt-get install -y openjdk-17-jre git docker.io curl unzip
    systemctl enable docker
    systemctl start docker

    # Install AWS CLI v2
    curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
    unzip -q /tmp/awscliv2.zip -d /tmp
    /tmp/aws/install

    # Install Terraform
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
    apt-get update -y
    apt-get install -y terraform
  EOF

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-jenkins-agent"
  })
}
