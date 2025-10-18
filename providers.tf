terraform {
  backend "s3" {
    bucket = "sandbox-backend-bucket-123456"
    key    = "sandbox-backend"
    region = "eu-central-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
