terraform {
  backend "s3" {
    bucket         = "tfstates3backup"
    key            = "tf-lab.tfstate"
    region         = "us-east-1"
    dynamodb_table = "state_lock"
  }
}