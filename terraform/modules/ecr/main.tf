resource "aws_ecr_repository" "main" {
  name                 ="${var.project_name}-ecr"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push =  true 
  }
  tags = {
    Name        = "${var.project_name}-ecr" 
    Environment =  var.environment 
    ManagedBy   = "Terraform" 
  }
}
