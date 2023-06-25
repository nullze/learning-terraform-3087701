terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" { # A provider is not a resource, it's what gives you access to resources. 
  region  = "us-east-2"
}
