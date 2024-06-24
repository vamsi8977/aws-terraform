resource "aws_eks_cluster" "k8" {
  name     = "${var.cluster_name}"
  role_arn = aws_iam_role.cluster.arn
  version  = "1.26"

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}"
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}

data "aws_eks_cluster" "existing_cluster" {
  name = aws_eks_cluster.k8.name
}

resource "aws_eks_node_group" "k8_node" {
  cluster_name    = data.aws_eks_cluster.existing_cluster.name
  node_group_name = "${var.cluster_name}"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }

  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  disk_size      = 20
  instance_types = ["t2.micro"]

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]
}
