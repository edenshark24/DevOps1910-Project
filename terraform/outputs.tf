# Networking
output "vpc_id" {
  description = "Main VPC ID"
  value       = module.networking.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.networking.private_subnet_ids
}

# EKS
output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = module.eks.cluster_endpoint
  sensitive   = true
}

# RDS
output "db_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_endpoint
  sensitive   = true
}

# ECR
output "ecr_repository_url" {
  description = "ECR repository URL for Docker images"
  value       = module.ecr.repository_url
}

# Jenkins
output "jenkins_private_ip" {
  description = "Jenkins EC2 instance private IP"
  value       = module.jenkins.jenkins_private_ip
}
