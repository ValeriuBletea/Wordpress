provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets_cidr = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id        = module.vpc.vpc_id
  ami           = "ami-0ddc798b3f1a5117e"
  instance_type = "t2.micro"
  key_name      = "wordpres-ssh"
  subnet_id     = module.vpc.public_subnets[0]  # Correct reference without ".id"
  ingress_ports = {
    http  = 80
    https = 443
    ssh   = 22
  }
}

module "rds" {
  source = "./modules/rds"

  vpc_id            = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  wordpress_sg_id   = module.ec2.wordpress_sg_id  # Now correctly referencing the output
  db_username       = "admin"
  db_password       = "adminadmin"
}

