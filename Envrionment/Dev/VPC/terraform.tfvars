#************************************************************
# AWS VPC - Terraform.tfvars 
#************************************************************

region    = "us-east-1"
vpc_name  = "Dev_cdc_vpc"
vpc_cidr  = "10.0.0.0/16"

public_subnets = [
  {
    cidr             = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    subnet_name      = "public-subnet-1"
  },
  {
    cidr             = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    subnet_name      = "public-subnet-2"
  }
]

private_subnets = [
  {
    cidr             = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    subnet_name      = "private-subnet-1"
  },
  {
    cidr             = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    subnet_name      = "private-subnet-2"
  }
]

tags = {
  Environment = "dev"
  Project     = "Terraform-VPC"
}
