# Cloud Delivery Platform

Cloud Delivery Platform is the application delivery layer for this repository. It turns the AWS infrastructure foundation into a complete CI/CD environment with Jenkins, automated testing, code quality checks, container delivery, infrastructure automation, and blue-green deployment workflows.

## Project Goal

The goal of the Cloud Delivery Platform is to show a working delivery pipeline built on top of the AWS foundation in this repository. Jenkins is used to orchestrate application testing, Docker image builds, SonarQube analysis, ECR publishing, Terraform automation, and blue-green deployment patterns.

## Application Included In This Folder

The sample application is a small Node.js and Express service located in `app/`.

### API Endpoints

- `GET /health` - returns a simple health response
- `GET /sum?a=1&b=2` - returns a JSON sum for two numeric query parameters
- `GET /echo/:message` - returns the message and a clamped length
- `GET /even/:value` - returns whether the supplied value is even

### Test Coverage

The app is set up with Jest and Supertest.

- Unit tests are in `app/tests/unit/`
- Integration tests are in `app/tests/integration/`
- The package scripts are defined in `app/package.json`

### Local App Commands

```powershell
cd cloud-delivery-platform\app
npm install
npm start
npm test
npm run test:unit
npm run test:integration
```

## Repository Structure

- `Jenkinsfile` - root pipeline for the sample app
- `app/` - Node.js application, test suites, and Dockerfile
- `jenkins/` - Jenkins controller/agent setup notes, plugin list, and Terraform
- `pipelines/` - optional pipeline assets and supporting notes
- `observability/` - Prometheus and Grafana assets

### Jenkins Folder Contents

- `jenkins/plugins.txt` - required Jenkins plugins to install
- `jenkins/setup.md` - controller and agent bootstrap steps
- `jenkins/terraform/` - Terraform for the Jenkins controller and private agent

## Infrastructure Reuse From The Main Terraform Stack

This project uses the AWS environment provisioned by the main Terraform configuration and should not recreate it manually.

- VPC, subnets, route tables, and NAT Gateway come from the main Terraform stack
- Security groups from the shared infrastructure are reused by Jenkins, SonarQube, and application resources
- Terraform state and locking should continue to use the S3 backend and DynamoDB table created in the root project

## Jenkins Workflow Overview

The intended CI/CD flow is:

1. Jenkins controller is provisioned in a public subnet.
2. A private build agent is connected over SSH and labeled `linux-agent`.
3. Jenkins checks out the repository from GitHub using a stored credential.
4. The pipeline builds and tests the app on the agent.
5. SonarQube scans are run and quality gates are enforced.
6. Docker images are built and pushed to AWS ECR.
7. Terraform can be driven from Jenkins for infrastructure changes.
8. Blue-green deployment and observability tasks are layered on top of the same stack.

## Jenkins Credentials Expected In The UI

The repository documentation assumes these credentials are created in Jenkins and referenced by ID in the pipelines.

- AWS access key and secret
- GitHub personal access token
- SonarQube token
- Docker / ECR credentials
- Slack webhook URL

## Required Jenkins Plugins

The Jenkins bootstrap files and setup guide expect the following plugins to be installed.

- Pipeline
- Git
- GitHub Branch Source
- Docker Pipeline
- Credentials Binding
- Pipeline Utility Steps
- SonarQube Scanner
- Blue Ocean

## Folder Layout

- `app/` - sample Node.js app, unit tests, integration tests, and Dockerfile
- `jenkins/` - controller/agent provisioning notes and Terraform
- `pipelines/` - pipeline-specific assets and supporting scripts
- `observability/` - monitoring configuration and dashboard assets
- `Jenkinsfile` - root declarative pipeline

## What The Report Should Show

The final submission for this project should include screenshots and explanations for:

- Jenkins dashboard after login
- Nodes page with the private agent online
- Credentials page with the required credential IDs visible and secret values masked
- Installed plugins page
- A successful multibranch pipeline run
- A failing build used for demonstration
- JUnit test results
- Slack or email notifications for success and failure
- SonarQube dashboard and quality gate results
- Docker build, Trivy or other scanning results, and ECR push evidence
- Terraform pipeline plan/apply/destroy evidence
- Blue-green deployment switch, rollback, and scaling history as required by the assignment brief

## Submission Notes

- Do not commit secrets, state files, `.terraform/` directories, private keys, or environment files.
- Keep the Cloud Delivery Platform report separate from the infrastructure foundation report because the deliverables and screenshots are different.
- The final report should include a contribution table for the team members and their work split.
