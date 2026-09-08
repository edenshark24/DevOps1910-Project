output "eks_sg_id" {
  description = "Security group for EKS cluster"
  value       = aws_security_group.eks.id
}

output "rds_sg_id" {
  description = "Security group for RDS"
  value       = aws_security_group.rds.id
}

output "alb_sg_id" {
  description = "Security group for ALB"
  value       = aws_security_group.alb.id
}

output "jenkins_sg_id" {
  description = "Security group for JENKINS pipeline"
  value       = aws_security_group.jenkins.id
}
