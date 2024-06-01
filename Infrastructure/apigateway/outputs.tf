output "invoke_url"{
  value = aws_api_gateway_stage.getapistage.invoke_url
}
output "hosted_ui_url"{
  value = "https://${aws_cognito_user_pool_domain.domain.domain}.auth.us-east-1.amazoncognito.com/login?client_id=${aws_cognito_user_pool_client.myclient.id}&response_type=token&scope=aws.cognito.signin.user.admin+email+openid+phone+profile&redirect_uri=${urlencode("https://${data.terraform_remote_state.s3.outputs.bucket_name}.s3.amazonaws.com/index.html")}"
}

output "logout_url"{
   value = "https://${aws_cognito_user_pool_domain.domain.domain}.auth.us-east-1.amazoncognito.com/logout?client_id=${aws_cognito_user_pool_client.myclient.id}&redirect_uri=${urlencode("https://${data.terraform_remote_state.s3.outputs.bucket_name}.s3.amazonaws.com/index.html")}"
}