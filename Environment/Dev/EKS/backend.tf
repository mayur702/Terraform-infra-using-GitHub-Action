terraform {
  backend "s3" {
    bucket = "mayur-terraform-states"
    key    = "Dev/EKS/terraformekst.tfstate"
    region = "us-east-1"
  }
}
