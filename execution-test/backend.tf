terraform {
  backend "s3" {
    bucket         = "assignmentbucket0204"
    key            = "terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "assignment0204"
  }
}
