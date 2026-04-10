output "jenkins_instance_id" {
  description = "ID of Jenkins instance"
  value       = aws_instance.jenkins.id
}

output "jenkins_private_ip" {
  description = "IP address of Jenkins instance"
  value       =  aws_instance.jenkins.private_ip  
}

