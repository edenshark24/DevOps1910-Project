output "cluster_name" {
  description = "Name of EKS cluster"
  value       =  aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "EKS cluster API server endpoint"
  value       = aws_eks_cluster.main.endpoint 
  sensitive = true  
}

output "cluster_certificate" {
  description = "certificate for EKS cluster"
  value = aws_eks_cluster.main.certificate_authority[0].data 
  sensitive = true
}
