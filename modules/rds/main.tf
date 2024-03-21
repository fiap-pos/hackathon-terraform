locals {
  ponto_username = "ponto"
  ponto_database_name = "ponto"

  postgres_version = "16.1"
  postgres_instance_class = "db.t3.micro"
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.ponto_application_tag_name}-subnet-group"
  subnet_ids = var.vpc_private_subnets
}


#Create a security group for RDS Database Instances
resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  vpc_id = var.vpc_id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Ponto database Password
resource "random_password" "ponto-db-user-password" {
  length = 16
  special = true
  override_special = "_%"
}

# --- Ponto RDS Database Instance ---

# Create Pagamentos RDS Database Instance
resource "aws_db_instance" "ponto_db_rds" {
    engine = "postgres"
    engine_version = local.postgres_version
    allocated_storage = 10
    instance_class = local.postgres_instance_class
    storage_type = "gp2"
    identifier = local.ponto_database_name
    db_name = local.ponto_database_name
    username = local.ponto_username
    password = random_password.ponto-db-user-password.result
    vpc_security_group_ids = [ aws_security_group.rds_sg.id ]
    db_subnet_group_name = aws_db_subnet_group.subnet_group.name
    publicly_accessible = false
    skip_final_snapshot = true

    depends_on = [ aws_security_group.rds_sg, aws_db_subnet_group.subnet_group ]
}

# Stores Pagamentos variables into AWS ssm

resource "aws_ssm_parameter" "ponto_rds_host" {
  name        = "/${var.ponto_application_tag_name}/${var.environment}/DB_HOST"
  description = "Database Host"
  type        = "String"
  value       = "${aws_db_instance.ponto_db_rds.endpoint}/${local.ponto_database_name}"
  depends_on = [ aws_db_instance.ponto_db_rds ]
}

resource "aws_ssm_parameter" "ponto_rds_username" {
  name        = "/${var.ponto_application_tag_name}/${var.environment}/DB_USERNAME"
  description = "Database Username"
  type        = "String"
  value       = "${local.ponto_username}"
  depends_on = [ aws_db_instance.ponto_db_rds ]
}

resource "aws_ssm_parameter" "ponto_rds_password" {
  name        = "/${var.ponto_application_tag_name}/${var.environment}/DB_PASSWORD"
  description = "Database Password"
  type        = "SecureString"
  value       = random_password.ponto-db-user-password.result
  depends_on = [ aws_db_instance.ponto_db_rds, random_password.ponto-db-user-password ]
}
