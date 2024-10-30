resource "aws_security_group" "wordpress_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = var.ingress_ports["http"]
    to_port     = var.ingress_ports["http"]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.ingress_ports["https"]
    to_port     = var.ingress_ports["https"]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.ingress_ports["ssh"]
    to_port     = var.ingress_ports["ssh"]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "wordpress-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.wordpress_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "wordpress_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.wordpress_sg.id]

 
  user_data     = file("${path.root}/wordpress.sh")
  
  tags = {
    Name = "wordpress-ec2"
  }
}
