terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  cloud {
    organization = "bervproject"

    workspaces {
      name = "aws-personal-iac"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
}

provider "aws" {
  alias  = "ap-southeast-3"
  region = "ap-southeast-3"
}

# ECR
resource "aws_ecr_repository" "demo_ecr" {
  provider = aws.ap-southeast-1

  name                 = "demo_ecr"
  image_tag_mutability = "MUTABLE"
  tags = {
    Environment = "dev"
  }
}

# Create a Dynamo DB
resource "aws_dynamodb_table" "ap-southeast-1" {
  provider = aws.ap-southeast-1

  hash_key         = "id"
  name             = "note"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1

  attribute {
    name = "id"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  tags = {
    Environment = "dev"
  }
}

resource "aws_dynamodb_global_table" "note" {
  depends_on = [
    aws_dynamodb_table.ap-southeast-1,
  ]
  provider = aws.ap-southeast-1

  name = "note"

  replica {
    region_name = "ap-southeast-1"
  }
}

# module "ecs" {
#  source = "./modules/ecs"
#  providers = {
#    aws = aws.ap-southeast-1
#  }
#}