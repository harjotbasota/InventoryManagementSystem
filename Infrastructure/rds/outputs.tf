output "secret_name" {
   value = aws_db_instance.project-rds.master_user_secret[0].secret_arn
}
output "db_name" {
   value = split(":",aws_db_instance.project-rds.endpoint)[0]
}
