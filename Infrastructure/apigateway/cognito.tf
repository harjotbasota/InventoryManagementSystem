resource "aws_cognito_user_pool" "userpool" {
  name = "userpool"
  username_attributes = ["email"]
  mfa_configuration = "OFF"
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
   } 
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }
}  
resource "aws_cognito_user_pool_domain" "domain" {
  domain       = "basota"
  user_pool_id = aws_cognito_user_pool.userpool.id
}
resource "aws_cognito_user_pool_client" "myclient"{
  name = "clientapp"
  user_pool_id = aws_cognito_user_pool.userpool.id
  generate_secret = false
  callback_urls   = ["https://${data.terraform_remote_state.s3.outputs.bucket_name}.s3.amazonaws.com/index.html"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["code", "implicit"]
  allowed_oauth_scopes   = ["email", "openid","phone","profile","aws.cognito.signin.user.admin"]
  supported_identity_providers  = ["COGNITO"]
}

