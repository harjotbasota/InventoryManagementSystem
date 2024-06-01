resource "aws_s3_bucket" "harjotbasota" {
  bucket = "harjotbasota"
}
resource "aws_s3_bucket_versioning" "bucketversioning" {
  bucket = aws_s3_bucket.harjotbasota.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_website_configuration" "staticwebsite" {
  bucket = aws_s3_bucket.harjotbasota.id

  index_document {
    suffix = "index.html"
  }
}
resource "aws_s3_bucket_public_access_block" "publicaccess" {
  bucket = aws_s3_bucket.harjotbasota.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "toallowpublicaccess" {
  bucket = aws_s3_bucket.harjotbasota.id
  policy = data.aws_iam_policy_document.bucketpolicy.json
  depends_on = [aws_s3_bucket_public_access_block.publicaccess]
}

data "aws_iam_policy_document" "bucketpolicy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::harjotbasota/*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
}
}
