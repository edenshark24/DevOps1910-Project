
variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "ID for VPC"
  type        = string
}

variable "jenkins_subnet_id" {
  description = "Subnet for Jenkins connection"
  type        = string
}

variable "jenkins_sg_id" {
  description = "Security Group for Jenkins ec2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for jenkins"
  type        = string
  default     = "m5.large"
}

variable "key_name" {
  description = "AWS pair for SSH access "
  type        = string
}



