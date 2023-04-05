terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }   
    remote = {
      version= "0.1.0"
      source = "tenstad/remote"
    }
  }
  backend "s3" {
    bucket = "test"
    key    = "keypair/keypair.tfstate"
    region = "us-east-1"
    dynamodb_table ="test-state-locking"
  }

}
provider "aws" {
  region = "us-east-1"
}
