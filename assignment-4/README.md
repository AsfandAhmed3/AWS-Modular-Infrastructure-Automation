# Assignment 4

This folder contains all work for Assignment 4. It reuses the AWS infrastructure provisioned in Assignment 3.

## Structure
- app/: sample application source code
- jenkins/: Jenkins setup docs, plugins, and Terraform for controller/agent
- pipelines/: Jenkinsfiles and pipeline assets
- observability/: Prometheus/Grafana configs and dashboards

## Setup Order
1. Provision Jenkins controller and agent using Terraform in jenkins/terraform.
2. Configure Jenkins UI (admin user, plugins, credentials, agent label).
3. Add the sample app in app/ and a Jenkinsfile in repo root.
4. Implement shared library and SonarQube integration.
5. Add ECR, Trivy, tfsec, Terraform pipeline, and blue-green stages.

## Notes
- Do not commit secrets, state files, or private keys.
- Use one branch per task with PRs to main.
