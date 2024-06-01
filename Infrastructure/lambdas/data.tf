data "terraform_remote_state" "vpc"{
  backend = "local"

  config = {
   path = "../vpc/terraform.tfstate"
   }
}
data "terraform_remote_state" "rds"{
  backend = "local"
  config = {
   path = "../rds/terraform.tfstate"
   }
}
