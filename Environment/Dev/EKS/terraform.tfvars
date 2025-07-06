aws_region = "us-east-1"

eks_cluster = {
  name     = "dev-eks-cluster"
  version  = "1.27"
}

eks_node_group = {
  name            = "eks-node-group"
  instance_types  = ["t3.medium"]
  desired_size    = 2
  min_size        = 1
  max_size        = 2
  disk_size       = 20
}
