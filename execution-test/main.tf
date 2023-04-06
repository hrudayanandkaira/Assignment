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

##############################################
module "ec2_security_group" {
  source                     = "../Security_group"
  security_group_name        = "first_SG"
  security_group_description = "This is the dev security "
  vpc_id = module.vpc.vpc_id
#   source_security_group_id = module.ec2_security_group.sg_id
  tags = {
    Name = "AWS_Dev_SG"
  }
}
##############################security group###############################################################
module "ec2_rule" {
  source            = "../Security_group/security_group_rules"
  security_group_id = module.ec2_security_group.sg_id
  security_group_rule = [

    {
      from_port   = 54663
      to_port     = 54663
      cidr_blocks = ["10.0.128.0/17"] #need to be changed
      protocol    = "tcp"
      type        = "ingress"
      description = "sg_1"
    },
    {
      from_port   = 54663
      to_port     = 54663
       cidr_blocks = ["10.0.0.0/17"] #need to be changed
      protocol    = "tcp"
      type        = "egress"
      description = "sg_2"
    },
  ]
}
########################################       vpc    #########################
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

locals {
  tags = {
    test = "unit-test"
  }
}
##################################  glue  #########################################################
module "glue" {
  source = "../glue"

  name        = "data_lake_tf_test"
  description = "Glue DB for Terraform test"
}
################################################## iam   #################################
module "iam" {
  source = "../iam"

  suffix       = "dev"
  s3_bucket    = "datalaketftests3bucket"
  external_ids = ["test_external_id_1", "test_external_id_2"]
  tags         = local.tags
}
###################################################  emr #####################################
module "emr" {
  source = "../emr"

  s3_bucket    = "data_lake_tf_test_s3_bucket"
  subnet_id    = module.ec2_security_group.sg_id
  tags         = local.tags
  cluster_name = "test-cluster"

  #
  iam_emr_autoscaling_role = module.iam.iam_emr_autoscaling_role
  iam_emr_service_role     = module.iam.iam_emr_service_role
  iam_emr_instance_profile = module.iam.iam_emr_instance_profile
}
 #########################  create a new sns topic            ##################################################
module "with-new-sns-topic" {
  source               = "../sns"
  email_addresses_list = ["my.test@mail.com"]
  sns_topic = {
    topic_name   = "mytest"
    display_name = "mytest"
    policy       = null
    kms_key_id   = "myKmsKeyId"
  }
  tags = { "global.env" = "test" }
}
