#!/bin/bash
sudo apt-get update
sudo apt-get install unzip
echo "Installing Terraform"
sleep 5
wget https://releases.hashicorp.com/terraform/1.8.2/terraform_1.8.2_linux_amd64.zip
unzip terraform_1.8.2_linux_amd64.zip
sudo mv terraform /usr/local/bin/

chmod +x main.sh
chmod +x insertlinks.sh
chmod +x cleanup.sh