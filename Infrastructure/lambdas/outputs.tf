output "get_lambda" {
   value =aws_lambda_function.get_lambda.invoke_arn
}
output "add_lambda" {
   value =aws_lambda_function.add_lambda.invoke_arn
}
output "delete_lambda" {
   value =aws_lambda_function.delete_lambda.invoke_arn
}
output "update_lambda" {
   value =aws_lambda_function.update_lambda.invoke_arn
}
output "search_lambda" {
   value =aws_lambda_function.search_lambda.invoke_arn
}

output "get_lambda_name" {
   value =aws_lambda_function.get_lambda.function_name
}
output "add_lambda_name" {
   value =aws_lambda_function.add_lambda.function_name
}
output "delete_lambda_name" {
   value =aws_lambda_function.delete_lambda.function_name
}
output "update_lambda_name" {
   value =aws_lambda_function.update_lambda.function_name
}
output "search_lambda_name" {
   value =aws_lambda_function.search_lambda.function_name
}
