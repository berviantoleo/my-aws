run "setup_tests" {
    module {
        source = "./tests/setup"
    }
}

mock_provider "aws" {
  alias = "ap-southeast-1"
}

mock_provider "aws" {
  alias = "ap-southeast-3"
}

override_module {
  target = module.instances
}


run "test_ecr" {
  command = plan

  variables {
    bucket_name = "${run.setup_tests.bucket_prefix}-aws-s3-website-test"
  }

  assert {
    condition     = aws_s3_bucket.cert_bucket.bucket == "${run.setup_tests.bucket_prefix}-aws-s3-website-test"
    error_message = "Invalid bucket name"
  }

  assert {
    condition = aws_s3_bucket_lifecycle_configuration.cert_bucket_lifecycle.rule[0].filter[0].prefix == "merged/"
    error_message = "Wrong lifecycle filter prefix"
  }

}