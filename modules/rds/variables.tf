variable "vpc_id" {
  description = "VPC ID for RDS instance"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for RDS instance"
  type        = list(string)
}

variable "wordpress_sg_id" {
  description = "Security group ID for the WordPress EC2 instance"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}
