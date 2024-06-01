resource "aws_s3_object" "index" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "index.html"
  source = "../../frontend/index.html"
  content_type = "text/html"
}
resource "aws_s3_object" "delete" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "delete.html"
  source = "../../frontend/delete.html"
  content_type = "text/html"
}
resource "aws_s3_object" "get" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "get.html"
  source = "../../frontend/get.html"
  content_type = "text/html"
}
resource "aws_s3_object" "getfiltered" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "getfiltered.html"
  source = "../../frontend/getfiltered.html"
  content_type = "text/html"
}
resource "aws_s3_object" "update" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "update.html"
  source = "../../frontend/update.html"
  content_type = "text/html"
}
resource "aws_s3_object" "upload" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "upload.html"
  source = "../../frontend/upload.html"
  content_type = "text/html"
}
