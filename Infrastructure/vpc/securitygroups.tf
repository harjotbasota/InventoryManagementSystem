resource "aws_security_group" "db-sg" {
  name = "project-db-sg"
  description = "Allow Connection on db port"
  vpc_id      = aws_vpc.project.id

  tags = {
    Name = "project-db-sg"
  }
}

resource "aws_security_group" "public-sg" {
  description = "Allow SSH connection on port 22"
  vpc_id      = aws_vpc.project.id
  name  = "project-public-sg"
  tags = {
    Name = "project-public-sg"
  }
}



resource "aws_security_group_rule" "public-outbound" {
  type              = "egress"
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  security_group_id = aws_security_group.public-sg.id
}
resource "aws_security_group_rule" "public-sm-outbound" {
  type              = "egress"
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  security_group_id = aws_security_group.public-sg.id
}
resource "aws_security_group_rule" "public-eighty-outbound" {
  type              = "egress"
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  security_group_id = aws_security_group.public-sg.id
}

resource "aws_security_group_rule" "public-inbound" {
  type              = "ingress"
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  security_group_id = aws_security_group.public-sg.id
}

resource "aws_security_group_rule" "db-inbound" {
  type              = "ingress"
  to_port           = 3306
  protocol          = "tcp"
  self              = true
  from_port         = 3306
  security_group_id = aws_security_group.db-sg.id
}

resource "aws_security_group_rule" "db-outbound" {
  type              = "egress"
  to_port           = 3306
  protocol          = "tcp"
  self              = true
  from_port         = 3306
  security_group_id = aws_security_group.db-sg.id
}
