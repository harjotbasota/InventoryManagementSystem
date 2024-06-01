resource "aws_default_network_acl" "project-acl" {
  default_network_acl_id = aws_vpc.project.default_network_acl_id
  tags = {
    Name = "project-acl"

  }
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

