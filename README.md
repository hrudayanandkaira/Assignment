
# Data lake project using Terraform

## RESOURCESS
- AWS SNS  
- AWS EMR
- AWS SECURITY GROUP
- AWS LAKEFORMATION
- AWS IAM
- AWS GLUE
- VPC, SUBNETS
## Usage

Github action is used for cicd of the terraform
-  for state locking dynamo db is used 
-  tf state file is saved in s3 bucket
-  all the resources are provision through the terraform
-  iam provised with least access
-  alerting email is my.test@mail.com
-  region "eu-west-1 "
-  always create a new branch when creating new implementation .
-  add comments for easy  troubleshooting and back trasing 
-  new touch tf file , make imlementation throught code.

```bash
$ terraform fmt
$ terraform init
$ terraform plan
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.40 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.40 |




<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
