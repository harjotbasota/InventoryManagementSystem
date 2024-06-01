resource "aws_vpc" "project" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames= true
  tags ={
     Name= "Project"
     }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.project.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "Public-subnet"
  }
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.project.id
  cidr_block = var.private_subnet1_cidr

  tags = {
    Name = "private-sub-1"
  }
  availability_zone = "us-east-1c"
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.project.id
  cidr_block = var.private_subnet2_cidr

  tags = {
    Name = "private-sub-2"
  }
  availability_zone = "us-east-1d"
}


