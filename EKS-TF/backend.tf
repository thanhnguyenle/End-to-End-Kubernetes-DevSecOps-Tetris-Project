terraform {
  backend "s3" {
    bucket       = "amzn-s3-eks-server"
    region       = "ap-southeast-1"
    key          = "terraform.tfstate"
    dynamodb_table ="terraform-eks-locks"
    use_lockfile = true
    encrypt      = true
  }
  required_version = ">=1.14.0"
  required_providers {
    aws = {
      version = ">= 5.49.0"
      source  = "hashicorp/aws"
    }
  }
}