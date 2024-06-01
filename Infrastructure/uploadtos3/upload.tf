resource "aws_s3_object" "index.html" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "index.html"
  source = "../../frontend/index.html"
}
resource "aws_s3_object" "delete.html" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "delete.html"
  source = "../../frontend/delete.html"
}
resource "aws_s3_object" "get.html" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "get.html"
  source = "../../frontend/get.html"
}
resource "aws_s3_object" "getfiltered.html" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "getfiltered.html"
  source = "../../frontend/getfiltered.html"
}
resource "aws_s3_object" "update.html" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "update.html"
  source = "../../frontend/update.html"
}
resource "aws_s3_object" "upload.html" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  key    = "upload.html"
  source = "../../frontend/upload.html"
}
