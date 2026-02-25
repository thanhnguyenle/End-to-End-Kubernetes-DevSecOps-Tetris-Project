# resource "aws_eks_node_group" "eks-node-group" {
#   cluster_name    = aws_eks_cluster.eks-cluster.name
#   node_group_name = var.eksnode-group-name
#   node_role_arn   = aws_iam_role.NodeGroupRole.arn
#   subnet_ids      = [data.aws_subnet.subnet.id, aws_subnet.public-subnet2.id]


#   scaling_config {
#     desired_size = 2
#     max_size     = 3
#     min_size     = 1
#   }

#   instance_types = ["t3a.medium"]
#   disk_size      = 20

#   depends_on = [
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
#     aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
#   ]
# }

resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "testing-spot-node"
  node_role_arn   = aws_iam_role.NodeGroupRole.arn
  subnet_ids      = [aws_subnet.public-subnet2.id] # Use 1 subnet to avoid cross-AZ data costs

  capacity_type  = "SPOT"
  instance_types = ["t3a.medium", "t3.medium"] # Diversify so it stays cheap

  scaling_config {
    desired_size = 1  # Just one for testing
    max_size     = 1
    min_size     = 1
  }

  # Reduced disk to the bare minimum for EKS (standard is 20GB, but you can go lower for tiny tests)
  disk_size = 20 

  # Forces the node to stay in one place to avoid inter-AZ transfer fees
  force_update_version = false 
}