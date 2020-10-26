# VPC configuration vars
region   = "us-east-1"
vpc_name = "Test_VPC"
vpc_tags = {
  Name        = "Test_VPC"
  Environment = "Test"
}
vpc_address            = "10.32.0.0/16"
public_subnet_address  = ["10.32.0.0/20", "10.32.16.0/20"]
public_subnet_zone     = ["us-east-1a", "us-east-1b"]
cluster_subnet_address = ["10.32.32.0/20", "10.32.48.0/20", "10.32.64.0/20"]
cluster_subnet_zone    = ["us-east-1a", "us-east-1b", "us-east-1c"]

# ECR repo configuration vars
repo_names = ["movie-analyst-api", "movie-analyst-ui"]

# EC2 instances configuration vars
key_name      = "linux_key"
instance_type = "t2.micro"
aws_key_pair  = "/home/developer/Documents/cloud-ssh-keys/linux_key.pem"

# DB configuraiton vars
db_instance_type = "db.t2.micro"
db_username      = "prueba"
db_password      = "password"
initial_db_name  = "movie_db"
engine           = "mysql"
engine_version   = "8.0"

# Backend terraform
bucket_name = "backend-tf-ramup-mai"
acl         = "private"
tags = {
  Environment = "Test",
  CreateBy    = "terraform"
}

