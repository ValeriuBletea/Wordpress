resource "aws_vpc" "wordpress_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "wordpress-vpc"
  }
}

resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = aws_vpc.wordpress_vpc.id
  tags = {
    Name = "wordpress_igw"
  }
}

resource "aws_route_table" "wordpress_rt" {
  vpc_id = aws_vpc.wordpress_vpc.id
  tags = {
    Name = "wordpress-rt"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.wordpress_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.wordpress_igw.id
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets_cidr)
  vpc_id = aws_vpc.wordpress_vpc.id
  cidr_block = var.public_subnets_cidr[count.index]
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "wordpress-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets_cidr)
  vpc_id = aws_vpc.wordpress_vpc.id
  cidr_block = var.private_subnets_cidr[count.index]
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "wordpress-private-subnet-${count.index + 1}"
  }
}

resource "aws_route_table_association" "public_association" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.wordpress_rt.id
}
