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
  security_group_id = module.ec2_security_group.security_group_id
  security_group_rule = [

    {
      from_port   = 54663
      to_port     = 54663
      cidr_blocks = ["0.0.0.0.0.0/32"] #need to be changed
      protocol    = "tcp"
      type        = "ingress"
      description = "Agent Server to Bamboo Server"
    },
    {
      from_port   = 54663
      to_port     = 54663
      cidr_blocks = ["0.0.0.0.0.0/32"] #need to be changed
      protocol    = "tcp"
      type        = "ingress"
      description = "Agent Server to Bamboo Server"
    },
  ]
}



module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  name = "single-instance"
  ami                    = "ami-01d9361b1c190a61b"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = module.ec2_security_group.sg_id
  subnet_id              = "subnet-0c9f8b746957b6e2b"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
