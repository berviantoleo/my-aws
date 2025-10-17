terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  alias = "ap-southeast-3"
  region = "ap-southeast-3"
  default_tags {
    tags = {
      Environment = "Dev"
    }
  }
}