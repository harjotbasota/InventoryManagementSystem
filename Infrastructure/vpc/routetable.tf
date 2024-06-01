resource "aws_default_route_table" "project-rt" {
  default_route_table_id = aws_vpc.project.default_route_table_id
  tags = {
     Name = "Project-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-igw.id
    }
}
resource "aws_internet_gateway" "project-igw" {
  vpc_id = aws_vpc.project.id

  tags = {
    Name = "Project-igw"
  }
}

resource "aws_route_table" "project-pvt-rt" {
  vpc_id = aws_vpc.project.id
  tags = {
    Name = "project-pvt-rt"
   }
}

resource "aws_route_table_association" "rds-sub-1" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.project-pvt-rt.id
}

resource "aws_route_table_association" "rds-sub-2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.project-pvt-rt.id
}
