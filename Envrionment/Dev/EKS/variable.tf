variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "eks_cluster" {
  description = "Configuration for AWS EKS cluster"
  type = object({
    name     = string
    version  = string
    vpc_id   = string
    subnets  = list(string)
  })
}

variable "eks_node_group" {
  description = "Configuration for EKS node group"
  type = object({
    name           = string
    instance_types = list(string)
    desired_size   = number
    min_size       = number
    max_size       = number
    disk_size      = number
  })
}
