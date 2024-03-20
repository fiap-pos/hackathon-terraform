module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
  cluster_name = var.cluster_name
}

module "eks" {
  source = "./modules/eks"
  aws_region = var.aws_region
  cluster_name = var.cluster_name
  cluster_instance_type = var.cluster_instance_type
  environment = var.environment
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  public_subnets = module.vpc.public_subnets
  depends_on = [ module.vpc.vpc_id ]
}	

module "rds" {
  source = "./modules/rds"
  aws_region = var.aws_region
  environment = var.environment
  ponto_application_tag_name = var.ponto_application_tag_name
  vpc_id = module.vpc.vpc_id
  depends_on = [ module.vpc.vpc_id ]
}

module "sqs" {
  source = "./modules/sqs"
  ponto_application_tag_name = var.ponto_application_tag_name
}