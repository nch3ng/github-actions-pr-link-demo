terraform {
  backend "s3" {
    bucket  = "be-prod-tfstate"
    key     = "pr-demo"
    region  = "us-west-1"
    encrypt = "true"
  }
}

provider "aws" {
  region = "us-west-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_provider"
}
