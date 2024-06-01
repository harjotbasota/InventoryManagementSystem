data "terraform_remote_state" "lambdas"{
  backend = "local"

  config = {
   path = "../lambdas/terraform.tfstate"
   }
}

data "terraform_remote_state" "s3"{
  backend = "local"
  config = {
   path = "../s3/terraform.tfstate"
   }
}
