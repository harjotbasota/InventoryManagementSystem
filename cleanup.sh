#!/bin/bash
cd ~/InventoryManagementSystem/Infrastructure/uploadtos3
terraform destroy -auto-approve
cd ../apigateway
terraform destroy -auto-approve
cd ../s3
terraform destroy -auto-approve
cd ../lambdas
terraform destroy -auto-approve
cd ../bastionhost
terraform destroy -auto-approve
cd ../rds
terraform destroy -auto-approve
cd ../vpc
terraform destroy -auto-approve