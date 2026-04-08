terraform {
  backend "s3" {
    bucket         = "aws-modular-infra-dev-tfstate-8e146e32"
    key            = "env/dev/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "aws-modular-infra-dev-tf-locks"
    encrypt        = true
  }
}
