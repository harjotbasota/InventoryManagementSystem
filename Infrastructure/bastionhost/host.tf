resource "aws_instance" "bastion-host" {
   tags = {
     Name = "bastion-host"
   }
   ami = var.ubuntu-ami
   instance_type = "t2.micro"
   key_name = var.ssh_key_name
   subnet_id = data.terraform_remote_state.vpc.outputs.public-subnet-id
   associate_public_ip_address = true
   vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.public-sg-id,data.terraform_remote_state.vpc.outputs.db-sg-id]
}
