resource "aws_lambda_function" "search_lambda"{
   filename="search.zip"
   function_name= "search-lambda"
   runtime = "python3.12"
   role = aws_iam_role.iam_for_lambda.arn
   handler = "getfiletered.lambda_handler"
   vpc_config{
     subnet_ids = [data.terraform_remote_state.vpc.outputs.private-sub-1-id,data.terraform_remote_state.vpc.outputs.private-sub-2-id]
     security_group_ids = [data.terraform_remote_state.vpc.outputs.db-sg-id]
   }
   environment {
    variables = {
      host = data.terraform_remote_state.rds.outputs.db_name
      user = "admin"
      password = var.db_password
      database = "inventory"
    } 
}  
}
