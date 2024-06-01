output "bastion-host-public-ip"{
  value = aws_instance.bastion-host.public_ip
}

output "bastion-host-instance-id"{
  value = aws_instance.bastion-host.id
}
