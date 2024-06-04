The Inventory Management Application is a powerful solution designed to centralize and streamline large inventories. Deployed on Amazon Web Services (AWS), it adheres to a serverless architecture, ensuring scalability and cost-effectiveness. Leveraging key services such as AWS Lambda for business logic, Amazon RDS (MySQL) for data storage, Amazon API Gateway for secure API exposure, Amazon Cognito for user authentication, and Amazon S3 for static asset storage, the application efficiently manages inventory items. Infrastructure provisioning is handled seamlessly using Terraform. Additionally, an EC2 bastion host facilitates secure access to the RDS database
To launch this project 
- This project needs aws region us-east-1 due to region name being hardcorded provider block of all the terraform modules and other terraform code such as availability zones
- Launch an ubuntu instance on aws which will serve as control node
- Clone this github repo at /home/ubuntu/
- Change the mod of setup.sh into executalbe( chmod +x setup.sh)
- Set your aws credentials at ~/.aws/credentials as default profile
- execute the setup.sh to install all the requirements for this project 
- Before you launch the project you might also need to update the variable files in all terraform modules i.e, InventoryManagementSystem/Infrastructure/terraform. 
  (NOTE --  some of the variables might need special attention such as ssh_key_name, ami for instance to use( use Ubuntu 22.04.4 LTS)
- Execute main.sh to launch this project
- Use the aws secrets manager to access the db password which you will prompted during the infrastructure deployment process
- Use s3 static website URL to access the website and sign up then login to get your authentication keys
- Execute cleanup.sh to delete the resources created from this project
