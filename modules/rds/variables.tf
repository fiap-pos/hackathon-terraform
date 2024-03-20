# Application Tag Name 
variable "ponto_application_tag_name" {
  type        = string
  description = "Application Tag Name"
}

variable "aws_region" {
  type = string
  description = "AWS Region"
}

variable "environment" {
  type = string
  description = "environment"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}