module "networking" {
  source = "./modules/networking"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs


  module "security" {
  source = "./modules/security"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.networking.vpc_id
  vpc_cidr          = var.vpc_cidr
  allowed_ssh_cidrs = var.allowed_ssh_cidrs
}

  module "jenkins" {
  source = "./modules/jenkins"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.networking.vpc_id
  jenkins_subnet_id = module.networking.private_subnet_ids[0]
  jenkins_sg_id = module.security.jenkins_sg_id
  key_name = var.key_name
}

module "rds" {
  source = "./modules/rds"
  project_name         = var.project_name
  environment          = var.environment
  rds_subnet_ids = module.networking.private_subnet_ids
   vpc_id            = module.networking.vpc_id
  rds_sg_id = module.security.rds_sg_id
  db_name  = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}


