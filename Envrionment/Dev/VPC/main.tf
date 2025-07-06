# ************************************************************
# Terraform Backend Configuration - S3 + DynamoDB
# ************************************************************

terraform {
  backend "s3" {
    bucket         = "mayur-terraform-states"
    key            = "Dev/VPC/terraform.tfstate"
    region         = var.aws_region
  }
}




#************************************************************
# AWS VPC - Terraform Configuration
#************************************************************

provider "aws" {
  region = var.region
}

#------------------------------------------------
# Create the VPC
#------------------------------------------------
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    { "Name" = var.vpc_name }
  )
}

#------------------------------------------------
# Create Public Subnets
#------------------------------------------------
resource "aws_subnet" "public_subnets" {
  for_each = { for subnet in var.public_subnets : subnet.cidr => subnet }

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = each.key
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true  # Enable auto-assignment of public IPs

  tags = merge(
    var.tags,
    { "Name" = each.value.subnet_name }
  )
}

#------------------------------------------------
# Create Private Subnets
#------------------------------------------------
resource "aws_subnet" "private_subnets" {
  for_each = { for subnet in var.private_subnets : subnet.cidr => subnet }

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = each.key
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false  # Private subnets do not get public IPs

  tags = merge(
    var.tags,
    { "Name" = each.value.subnet_name }
  )
}

#------------------------------------------------
# Create an Internet Gateway (IGW) for Public Subnets
#------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(
    var.tags,
    { "Name" = "${var.vpc_name}-igw" }
  )
}

#------------------------------------------------
# Create a Route Table for Public Subnets
#------------------------------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(
    var.tags,
    { "Name" = "${var.vpc_name}-public-rt" }
  )
}

# Route all outbound traffic to the Internet Gateway
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Public Subnets with the Public Route Table
resource "aws_route_table_association" "public_rt_assoc" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

#------------------------------------------------
# Create Security Groups
#------------------------------------------------
resource "aws_security_group" "vpc_sg" {
  vpc_id = aws_vpc.main_vpc.id

  # Allow inbound SSH
  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.vpc_name}-sg" }
  )
}
