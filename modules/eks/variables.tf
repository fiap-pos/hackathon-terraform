variable "aws_region" {
  type    = string
  description = "The AWS region to deploy the EKS cluster"	
}

variable "cluster_name" {
  type = string
  description = "The name of the EKS cluster"	
}

variable "cluster_instance_type" {
  type = string
  description = "The instance type to use for the EKS cluster"
}

variable "environment" {
  type    = string
  description = "The environment in which the resources are being created"
}

variable "vpc_id" {
  type = string
  description = "The VPC ID in which the EKS cluster will be deployed"
  
}

variable "private_subnets" {
  type = list(string)
  description = "The private subnets in which the EKS cluster will be deployed"
}

variable "public_subnets" {
    type = list(string)
    description = "The public subnets in which the EKS cluster will be deployed"
}
