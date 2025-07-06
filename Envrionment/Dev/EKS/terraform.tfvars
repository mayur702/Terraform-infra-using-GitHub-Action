aws_region = "us-east-1"

eks_cluster = {
  name     = "dev-eks-cluster"
  version  = "1.27"
  vpc_id   = "vpc-6789abcdef0"  # Replace with your VPC ID
  subnets  = ["subnet-012389abcdef0", "subnet-0fedcb543210"]  # Replace with your subnet IDs
}

eks_node_group = {
  name            = "eks-node-group"
  instance_types  = ["t3.medium"]
  desired_size    = 2
  min_size        = 1
  max_size        = 3
  disk_size       = 20
}
