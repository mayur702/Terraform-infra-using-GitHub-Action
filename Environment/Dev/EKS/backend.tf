terraform {
  backend "s3" {
    bucket = "mayur-terraform-states"
    key    = "Dev/EKS/terraformeks.tfstate"
    region = "us-east-1"
  }
}
