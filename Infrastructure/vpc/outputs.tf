output "project-vpc-id"{
  value = aws_vpc.project.id
}

output "private-sub-1-id"{
  value = aws_subnet.private.id
}

output "private-sub-2-id"{
  value = aws_subnet.private2.id
}

output "db-sg-id"{
  value = aws_security_group.db-sg.id
}

output "public-subnet-id"{
  value = aws_subnet.public.id
  }

output "public-sg-id" {
  value = aws_security_group.public-sg.id
  }
