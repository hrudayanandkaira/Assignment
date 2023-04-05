terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.65"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-01d9361b1c190a61b"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-077b363f385bf4006"]
  subnet_id              = "subnet-0c9f8b746957b6e2b"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
