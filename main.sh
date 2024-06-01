#!/bin/bash
cd ./Infrastructure/vpc
terraform init
terraform apply -auto-approve
cd ../rds
terraform init
terraform apply -auto-approve
cd ../bastionhost
terraform init
terraform apply -auto-approve
cd ../lambdas
terraform init
terraform apply -auto-approve
cd ../s3
terraform init
terraform apply -auto-approve
cd ../apigateway
terraform init
terraform apply -auto-approve
cd ../..
bash insertlinks.sh
cd ./Infrastructure/uploadtos3
terraform init
terraform apply -auto-approve