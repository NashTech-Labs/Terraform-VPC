# VPC 
resource "aws_vpc" "terra-vpc" {
  cidr_block           = "10.0.0.0/16"   
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "terra-vpc"
  }
}

# Subnets
resource "aws_subnet" "terra-public-1" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "terra-public-1"
  }
}

resource "aws_subnet" "terra-public-2" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "terra-public-2"
  }
}

resource "aws_subnet" "terra-public-3" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "terra-public-3"
  }
}

resource "aws_subnet" "terra-private-1" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "terra-private-1"
  }
}

resource "aws_subnet" "terra-private-2" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "terra-private-2"
  }
}

resource "aws_subnet" "terra-private-3" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "terra-private-3"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "tig-gw" {
  vpc_id = aws_vpc.terra-vpc.id

  tags = {
    Name = "terra-ig"
  }
}

# Route Tables
resource "aws_route_table" "terra-public" {
  vpc_id = aws_vpc.terra-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tig-gw.id
  }

  tags = {
    Name = "rt-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "terra-public-1-a" {
  subnet_id      = aws_subnet.terra-public-1.id
  route_table_id = aws_route_table.terra-public.id
}

resource "aws_route_table_association" "terra-public-2-a" {
  subnet_id      = aws_subnet.terra-public-2.id
  route_table_id = aws_route_table.terra-public.id
}

resource "aws_route_table_association" "terra-public-3-a" {
  subnet_id      = aws_subnet.terra-public-3.id
  route_table_id = aws_route_table.terra-public.id
}