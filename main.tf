terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  cloud {
    organization = "bervproject"

    workspaces {
      name = "aws-personal-iac"
    }
  }
}

# ECR
# resource "aws_ecr_repository" "demo_ecr" {
#   provider = aws.ap-southeast-3

#   name                 = "demo_ecr"
#   image_tag_mutability = "MUTABLE"
#   tags = {
#     Environment = "dev"
#   }
# }

# # Create a Dynamo DB
# resource "aws_dynamodb_table" "ap-southeast-3" {
#   provider = aws.ap-southeast-3

#   hash_key         = "id"
#   name             = "note"
#   stream_enabled   = true
#   stream_view_type = "NEW_AND_OLD_IMAGES"
#   read_capacity    = 1
#   write_capacity   = 1

#   attribute {
#     name = "id"
#     type = "S"
#   }

#   ttl {
#     attribute_name = "TimeToExist"
#     enabled        = true
#   }

#   tags = {
#     Environment = "dev"
#   }
# }

resource "aws_s3_bucket" "cert_bucket" {
  provider = aws.ap-southeast-3
  bucket   = "change"
}

resource "aws_s3_bucket_lifecycle_configuration" "cert_bucket_lifecycle" {
  provider = aws.ap-southeast-3

  bucket = aws_s3_bucket.cert_bucket.id

  rule {
    id = "deletion-rule-1"

    filter {
      prefix = "merged/"
    }

    expiration {
      days = 7
    }

    # ... other transition/expiration actions ...

    status = "Enabled"
  }
}

# module "ecs" {
#  source = "./modules/ecs"
#  providers = {
#    aws = aws.ap-southeast-1
#  }
#}
