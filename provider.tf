provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"

  default_tags {
    tags = {
      Environment = "Dev"
    }
  }
}

provider "aws" {
  alias  = "ap-southeast-3"
  region = "ap-southeast-3"

  default_tags {
    tags = {
      Environment = "Dev"
    }
  }
}