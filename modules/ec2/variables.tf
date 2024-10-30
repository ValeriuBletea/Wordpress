variable "vpc_id" {
  description = "VPC ID for EC2 instance"
  type        = string
}

variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for EC2 instance"
  type        = string
}

variable "ingress_ports" {
  description = "Map of ingress ports"
  type        = map(number)
}
