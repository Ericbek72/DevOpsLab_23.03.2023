resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = var.state_file_bucket

  tags = {
    Name        = "tfstate_file_bucket"
    Environment = "prod"
  }
}

resource "aws_s3_bucket_acl" "versioning_bucket_acl" {
  bucket = aws_s3_bucket.tfstate_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.tfstate_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.tfstate_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}