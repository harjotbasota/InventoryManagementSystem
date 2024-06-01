resource "aws_api_gateway_authorizer" "cognito" {
  name                   = "cognito"
  rest_api_id            = aws_api_gateway_rest_api.projectapigw.id
  type                   = "COGNITO_USER_POOLS"
  provider_arns          = [aws_cognito_user_pool.userpool.arn]
}
