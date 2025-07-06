#************************************************************
# AWS VPC - Variables
#************************************************************

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

# Add your variable declarations here

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "public_subnets" {
  description = "List of public subnets"
  type = list(object({
    cidr             = string
    availability_zone = string
    subnet_name      = string
  }))
}

variable "private_subnets" {
  description = "List of private subnets"
  type = list(object({
    cidr             = string
    availability_zone = string
    subnet_name      = string
  }))
}

variable "tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}
