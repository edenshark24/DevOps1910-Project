output "repository_url" {
  description = "Url for ecr repository"
  value       =  aws_ecr_repository.main.repository_url
}

output "repository_name" {
  description = "Name for ecr repository"
  value       =  aws_ecr_repository.main.name
}

