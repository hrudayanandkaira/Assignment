terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.65"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}
module "ec2_security_group" {
  source                     = "../Security_group"
  security_group_name        = "first_SG"
  security_group_description = "This is the dev security "
  vpc_id = "vpc-07b1c88ead1bdcf74"
  tags = {
    Name = "AWS_Dev_SG"
  }
}

module "ec2_rule" {
  source            = "../Security_group/security_group_rules"
  security_group_id = module.ec2_security_group.sg_id
  security_group_rule = [

    {
      from_port   = 54663
      to_port     = 54663
#       cidr_blocks = ["0.0.0.0.0.0/32"] #need to be changed
      protocol    = "tcp"
      type        = "ingress"
      description = "sg_1"
    },
    {
      from_port   = 54663
      to_port     = 54663
#       cidr_blocks = ["0.0.0.0.0.0/32"] #need to be changed
      protocol    = "tcp"
      type        = "egress"
      description = "sg_2"
    },
  ]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = [ "us-west-1a"]
  private_subnets = ["10.0.0.0/17"]
  public_subnets  = ["10.0.128.0/17"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  name = "single-instance"
  ami                    = "ami-01d9361b1c190a61b"
  instance_type          = "t2.micro"
  monitoring             = true
#   security_group_id = [module.ec2_security_group.sg_id]
#   vpc_id              =  module.vpc.vpc_id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
 ###################################s3 bucket creation################ 
  module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket"
  acl    = "private"

  versioning = {
    enabled = true
  }

}
