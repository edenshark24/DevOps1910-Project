# ============================================
# IAM ROLE FOR EKS CONTROL PLANE
# ============================================
# This role allows the EKS SERVICE (AWS managed brain)
# to manage AWS resources on your behalf
# Like creating load balancers, modifying security groups etc.

resource "aws_iam_role" "eks_cluster" {
  name = "${var.project_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = "${var.project_name}-eks-cluster-role"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Attach EKS Cluster Policy to cluster role
# This is AWS managed policy that gives EKS
# all permissions it needs to run the control plane
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

# ============================================
# IAM ROLE FOR EKS NODE GROUP (EC2 instances)
# ============================================
# This role allows EC2 instances (worker nodes)
# to join the cluster and interact with AWS services
# Like pulling images from ECR, sending logs to CloudWatch

resource "aws_iam_role" "eks_nodes" {
  name = "${var.project_name}-eks-nodes-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = "${var.project_name}-eks-nodes-role"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Policy 1 - AmazonEKSWorkerNodePolicy
# Allows nodes to connect to EKS cluster
# Like a "membership card" to join the cluster
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

# Policy 2 - AmazonEKS_CNI_Policy
# CNI = Container Network Interface
# Allows nodes to manage pod networking
# Without this pods can't get IP addresses! 
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

# Policy 3 - AmazonEC2ContainerRegistryReadOnly
# Allows nodes to PULL images from ECR
# ReadOnly because nodes only pull, never push
resource "aws_iam_role_policy_attachment" "eks_ecr_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}

# ============================================
# EKS CLUSTER (Control Plane)
# ============================================
# This is the actual Kubernetes cluster
# AWS manages the control plane completely
# You just define the configuration

resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-cluster"
  role_arn = aws_iam_role.eks_cluster.arn  # ARN not name!
  version  = var.cluster_version

  vpc_config {
    subnet_ids         = var.eks_subnet_ids
    security_group_ids = [var.eks_sg_id]  # list!
  }

  # Wait for cluster policy before creating cluster
  # Without IAM role ready, cluster creation fails
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]

  tags = {
    Name        = "${var.project_name}-cluster"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# ============================================
# EKS NODE GROUP (Worker Nodes)
# ============================================
# These are the actual EC2 instances that run your pods
# Managed node group means AWS handles:
# → Node provisioning
# → Node updates
# → Node termination
# You just define the scaling config

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = aws_iam_role.eks_nodes.arn  # ARN not name!
  subnet_ids      = var.eks_subnet_ids

  # instance_types is always a list in AWS
  # even if you only have one type
  instance_types = [var.node_instance_type]

  scaling_config {
    min_size     = var.min_nodes
    max_size     = var.max_nodes
    desired_size = var.desired_nodes
  }

  # Wait for ALL three node policies before creating nodes
  # Missing any policy = nodes can't function properly
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_policy,
  ]

  tags = {
    Name        = "${var.project_name}-node-group"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
