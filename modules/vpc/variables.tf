variable "vpc_name" {
  type    = string
  description = "VPC Name"
}

# --- EKS variables ----

variable "cluster_name" {
  type = string
  description = "EKS Cluster Name"
}
