resource "aws_kms_key" "project-kms" {
  description             = "KMS key for db secrets manager encryption"
}

resource "aws_kms_key_policy" "project-kms" {
  key_id = aws_kms_key.project-kms.id
  policy = jsonencode({
    Id = "project-policy"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }

        Resource = "*"
        Sid      = "Allow encryption and decrytion"
      },
    ]
    Version = "2012-10-17"
  })
}
