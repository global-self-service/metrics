terraform {
  backend "s3" {
    bucket         = "global-self-service-dev-terraform-state"
    key            = "metrics.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
