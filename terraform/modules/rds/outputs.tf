output "db_endpoint" {
  description = "endpoint of database"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}

output "db_name" {
  description = "name for database"
  value       = aws_db_instance.main.db_name
}
