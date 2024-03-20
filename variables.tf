# ---- AWS Variables ----
variable "aws_region" {
  type = string
  description = "AWS Region"
  default = "us-east-1"
}

# ---- Common variables ----
variable "environment" {
  type = string
  description = "environment"
  default = "dev"
}

variable "default_tag" {
  type = string
  description = "default tag"
  default = "hackathon"
}

# ---- Ponto Application Variables ----

# Application Tag Name 
variable "ponto_application_tag_name" {
  type        = string
  description = "Ponto application tag Name"
  default = "hackathon-ponto"
}

# --- VPC Variables ----

variable "vpc_name" {
  type    = string
  default = "hackathon-61-eks"
}

# --- EKS variables ----

variable "cluster_name" {
  type = string
  default = "hackthon-61"
}

variable "cluster_instance_type" {
  type    = string
  default = "t3.medium"
}