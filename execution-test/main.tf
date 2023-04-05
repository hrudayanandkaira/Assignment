terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.65"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}
module "ec2_security_group" {
  source                     = "../Security_group"
  security_group_name        = "first_SG"
  security_group_description = "This is the dev security grp for Atlassian Bamboo"
  vpc_id = "vpc-07b1c88ead1bdcf74"
  tags = {
    Name = "EQ_AWS_Dev_Atlassian_Bamboo"
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
      description = "Agent Server to Bamboo Server"
    },
    {
      from_port   = 54663
      to_port     = 54663
#       cidr_blocks = ["0.0.0.0.0.0/32"] #need to be changed
      protocol    = "tcp"
      type        = "ingress"
      description = "Agent Server to Bamboo Server"
    },
  ]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

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
  vpc_id              =  module.vpc.vpc_id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
