terraform {
  backend "s3" {
    bucket       = "amzn-s3-tetris-server"
    region       = "us-east-1"
    key          = "amzn-s3-jenkins-server/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
  required_version = ">=1.13.3"
  required_providers {
    aws = {
      version = ">= 6.23.0"
      source  = "hashicorp/aws"
    }
  }
}