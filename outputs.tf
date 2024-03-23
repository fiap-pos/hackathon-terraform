# RDS outputs
output "security_group_id" { value = module.rds.security_group_id }


output "ponto_db_host" { value = module.rds.ponto_db_host }
output "ponto_username" { value = module.rds.ponto_username }
output "ponto_user_password" { 
  sensitive = true
  value = module.rds.ponto_user_password 
}

# SQS outputs
output "ponto_queue_url" { value = module.sqs.ponto_queue_url }
output "ponto_queue_dlq_url" { value = module.sqs.ponto_queue_dlq_url }

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
}
