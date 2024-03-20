# Outputs to Display

output "security_group_id" { value = aws_security_group.rds_sg.id }
output "ponto_db_host" { value = "${aws_db_instance.ponto_db_rds.endpoint}/${local.ponto_database_name}" }
output "ponto_username" { value = local.ponto_username }
output "ponto_user_password" { 
  sensitive = true
  value = random_password.ponto-db-user-password.result 
}