resource "aws_api_gateway_rest_api" "projectapigw" {
  name = "project-api-gw"
}

resource "aws_api_gateway_resource" "api" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  parent_id   = aws_api_gateway_rest_api.projectapigw.root_resource_id
  path_part   = "api"
}
resource "aws_api_gateway_resource" "search" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  parent_id   = aws_api_gateway_rest_api.projectapigw.root_resource_id
  path_part   = "search"
}

resource "aws_api_gateway_method" "getMethod" {
  rest_api_id   = aws_api_gateway_rest_api.projectapigw.id
  resource_id   = aws_api_gateway_resource.api.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito.id
}
resource "aws_api_gateway_method" "putMethod" {
  rest_api_id   = aws_api_gateway_rest_api.projectapigw.id
  resource_id   = aws_api_gateway_resource.api.id
  http_method   = "PUT"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito.id
}
resource "aws_api_gateway_method" "postMethod" {
  rest_api_id   = aws_api_gateway_rest_api.projectapigw.id
  resource_id   = aws_api_gateway_resource.api.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito.id
}
resource "aws_api_gateway_method" "deleteMethod" {
  rest_api_id   = aws_api_gateway_rest_api.projectapigw.id
  resource_id   = aws_api_gateway_resource.api.id
  http_method   = "DELETE"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito.id
}
resource "aws_api_gateway_method" "optionsMethod" {
  rest_api_id   = aws_api_gateway_rest_api.projectapigw.id
  resource_id   = aws_api_gateway_resource.api.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  depends_on = [ aws_api_gateway_integration.getapiintegration,aws_api_gateway_integration.putapiintegration,aws_api_gateway_integration.postapiintegration,aws_api_gateway_integration.deleteapiintegration ]
}
resource "aws_api_gateway_method" "searchMethod" {
  rest_api_id   = aws_api_gateway_rest_api.projectapigw.id
  resource_id   = aws_api_gateway_resource.search.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito.id
}
resource "aws_api_gateway_method" "searchoptionsMethod" {
  rest_api_id   = aws_api_gateway_rest_api.projectapigw.id
  resource_id   = aws_api_gateway_resource.search.id
  http_method   = "OPTIONS"
  authorization = "NONE"
   depends_on = [ aws_api_gateway_integration.getapiintegration,aws_api_gateway_integration.putapiintegration,aws_api_gateway_integration.postapiintegration,aws_api_gateway_integration.deleteapiintegration]
}
resource "aws_api_gateway_integration" "getapiintegration" {
  rest_api_id             = aws_api_gateway_rest_api.projectapigw.id
  resource_id             = aws_api_gateway_resource.api.id
  type                    = "AWS"
  http_method             = aws_api_gateway_method.getMethod.http_method
  integration_http_method = "POST"
  uri                     = data.terraform_remote_state.lambdas.outputs.get_lambda
  depends_on = [ aws_api_gateway_method.getMethod ]
}
resource "aws_api_gateway_integration" "putapiintegration" {
  rest_api_id             = aws_api_gateway_rest_api.projectapigw.id
  resource_id             = aws_api_gateway_resource.api.id
  type                    = "AWS"
  http_method             = aws_api_gateway_method.putMethod.http_method
  integration_http_method = "POST"
  uri                     = data.terraform_remote_state.lambdas.outputs.update_lambda
  depends_on = [ aws_api_gateway_method.putMethod ]
}
resource "aws_api_gateway_integration" "postapiintegration" {
  rest_api_id             = aws_api_gateway_rest_api.projectapigw.id
  resource_id             = aws_api_gateway_resource.api.id
  type                    = "AWS"
  http_method             = aws_api_gateway_method.postMethod.http_method
  integration_http_method = "POST"
  uri                     = data.terraform_remote_state.lambdas.outputs.add_lambda
   depends_on = [ aws_api_gateway_method.postMethod ]
}
resource "aws_api_gateway_integration" "deleteapiintegration" {
  rest_api_id             = aws_api_gateway_rest_api.projectapigw.id
  resource_id             = aws_api_gateway_resource.api.id
  type                    = "AWS"
  http_method             = aws_api_gateway_method.deleteMethod.http_method
  integration_http_method = "POST"
  uri                     = data.terraform_remote_state.lambdas.outputs.delete_lambda
   depends_on = [ aws_api_gateway_method.deleteMethod ]
}
resource "aws_api_gateway_integration" "optionsapiintegration" {
  rest_api_id             = aws_api_gateway_rest_api.projectapigw.id
  resource_id             = aws_api_gateway_resource.api.id
  type                    = "MOCK"
  http_method             = aws_api_gateway_method.optionsMethod.http_method
  integration_http_method = "OPTIONS"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  depends_on = [ aws_api_gateway_method.optionsMethod]
}
resource "aws_api_gateway_integration" "searchapiintegration" {
  rest_api_id             = aws_api_gateway_rest_api.projectapigw.id
  resource_id             = aws_api_gateway_resource.search.id
  type                    = "AWS"
  http_method             = aws_api_gateway_method.searchMethod.http_method
  integration_http_method = "POST"
  uri                     = data.terraform_remote_state.lambdas.outputs.search_lambda
  depends_on = [aws_api_gateway_method.searchMethod]
}
resource "aws_api_gateway_integration" "searchoptionsapiintegration" {
  rest_api_id             = aws_api_gateway_rest_api.projectapigw.id
  resource_id             = aws_api_gateway_resource.search.id
  type                    = "MOCK"
  http_method             = aws_api_gateway_method.searchoptionsMethod.http_method
  integration_http_method = "OPTIONS"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  depends_on = [ aws_api_gateway_method.searchoptionsMethod]
}

resource "aws_api_gateway_method_response" "response_getapi" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.getMethod.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"     = true
  }
}
resource "aws_api_gateway_method_response" "response_putapi" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.putMethod.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"     = true
  }
}
resource "aws_api_gateway_method_response" "response_postapi" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.postMethod.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"     = true
  }
}
resource "aws_api_gateway_method_response" "response_deleteapi" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.deleteMethod.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"     = true
  }
}
resource "aws_api_gateway_method_response" "response_optionsapi" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.optionsMethod.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
resource "aws_api_gateway_method_response" "response_searchapi" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.searchMethod.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"     = true
  }
}
resource "aws_api_gateway_method_response" "response_searchoptionsapi" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.searchoptionsMethod.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "getapiIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.getMethod.http_method
  status_code = aws_api_gateway_method_response.response_getapi.status_code
  response_parameters = {"method.response.header.Access-Control-Allow-Origin"="'*'"}
  response_templates = {
    "application/json" = <<EOF
EOF
  }
}
resource "aws_api_gateway_integration_response" "putapiIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.putMethod.http_method
  status_code = aws_api_gateway_method_response.response_putapi.status_code
  response_parameters = {"method.response.header.Access-Control-Allow-Origin"="'*'"}
  response_templates = {
    "application/json" = <<EOF
EOF
  }
}
resource "aws_api_gateway_integration_response" "postapiIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.postMethod.http_method
  status_code = aws_api_gateway_method_response.response_postapi.status_code
  response_parameters = {"method.response.header.Access-Control-Allow-Origin"="'*'"}
  response_templates = {
    "application/json" = <<EOF
EOF
  }
}
resource "aws_api_gateway_integration_response" "deleteapiIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.deleteMethod.http_method
  status_code = aws_api_gateway_method_response.response_deleteapi.status_code
  response_parameters = {"method.response.header.Access-Control-Allow-Origin"="'*'"}
  response_templates = {
    "application/json" = <<EOF
EOF
  }
}
resource "aws_api_gateway_integration_response" "optionsapiIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.optionsMethod.http_method
  status_code = aws_api_gateway_method_response.response_optionsapi.status_code

  response_parameters = {"method.response.header.Access-Control-Allow-Headers"="'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
                        "method.response.header.Access-Control-Allow-Methods"="'DELETE,GET,PUT,POST,OPTIONS'",
                        "method.response.header.Access-Control-Allow-Origin"="'*'"
    }
}
resource "aws_api_gateway_integration_response" "searchapiIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.searchMethod.http_method
  status_code = aws_api_gateway_method_response.response_searchapi.status_code
  response_parameters = {"method.response.header.Access-Control-Allow-Origin"="'*'"}
  response_templates = {
    "application/json" = <<EOF
EOF
  }
}
resource "aws_api_gateway_integration_response" "searchoptionsapiIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.searchoptionsMethod.http_method
  status_code = aws_api_gateway_method_response.response_searchoptionsapi.status_code

  response_parameters = {"method.response.header.Access-Control-Allow-Headers"="'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
                        "method.response.header.Access-Control-Allow-Methods"="'POST,OPTIONS'",
                        "method.response.header.Access-Control-Allow-Origin"="'*'"
    }
}
resource "aws_lambda_permission" "getapi_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambdas.outputs.get_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.projectapigw.execution_arn}/*/GET/api"
}
resource "aws_lambda_permission" "putapi_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambdas.outputs.update_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.projectapigw.execution_arn}/*/PUT/api"
}
resource "aws_lambda_permission" "postapi_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambdas.outputs.add_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.projectapigw.execution_arn}/*/POST/api"
}
resource "aws_lambda_permission" "deleteapi_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambdas.outputs.delete_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.projectapigw.execution_arn}/*/DELETE/api"
}
resource "aws_lambda_permission" "searchapi_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambdas.outputs.search_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.projectapigw.execution_arn}/*/POST/search"
}

resource "aws_api_gateway_deployment" "apideployment" {
  rest_api_id = aws_api_gateway_rest_api.projectapigw.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.api.id,
      aws_api_gateway_resource.search.id,
      aws_api_gateway_method.getMethod.id,
      aws_api_gateway_method.putMethod.id,
      aws_api_gateway_method.postMethod.id,
      aws_api_gateway_method.deleteMethod.id,
      aws_api_gateway_method.searchMethod.id,
      aws_api_gateway_integration.getapiintegration.id,
      aws_api_gateway_integration.putapiintegration.id,
      aws_api_gateway_integration.postapiintegration.id,
      aws_api_gateway_integration.deleteapiintegration.id,
      aws_api_gateway_integration.searchapiintegration.id,
      aws_api_gateway_method.optionsMethod.id,
      aws_api_gateway_method.searchoptionsMethod.id,
      aws_api_gateway_integration.searchoptionsapiintegration.id,
      aws_api_gateway_integration.optionsapiintegration.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [ aws_api_gateway_integration_response.searchoptionsapiIntegrationResponse,aws_api_gateway_integration_response.optionsapiIntegrationResponse ]

}


resource "aws_api_gateway_stage" "getapistage" {
  deployment_id = aws_api_gateway_deployment.apideployment.id
  rest_api_id   = aws_api_gateway_rest_api.projectapigw.id
  stage_name    = "stage"
}
