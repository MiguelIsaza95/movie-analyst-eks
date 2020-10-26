# VPC configuration vars
variable "region" {}
variable "vpc_name" {}
variable "vpc_tags" {}
variable "vpc_address" {}
variable "public_subnet_address" {
  type    = list(string)
  default = []
}
variable "public_subnet_zone" {
  type    = list(string)
  default = []
}
variable "cluster_subnet_address" {
  type    = list(string)
  default = []
}
variable "cluster_subnet_zone" {
  type    = list(string)
  default = []
}

variable "enabled_metrics" {
  type = list(string)

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

# ECR repo configuration vars
variable "repo_names" {
  type    = list(string)
  default = []
}

# EC2 instances configuration vars
variable "key_name" {}
variable "instance_type" {}
variable "aws_key_pair" {}

# DB configuraiton vars

variable "db_instance_type" {}
variable "db_username" {}
variable "db_password" {}
variable "initial_db_name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "engine" {}
variable "engine_version" {}

# Backend vars
variable "bucket_name" {}
variable "acl" {}
variable "tags" {}
