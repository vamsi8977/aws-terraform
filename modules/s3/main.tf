resource "aws_s3_bucket" "s3" {
  bucket        = "${var.env}-infra-core"
  force_destroy = true
  tags = {
    name = "${var.env}-infra-core"
    env  = var.env
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "algorithm" {
  bucket = aws_s3_bucket.s3.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3.bucket
  versioning_configuration {
    status = "Disabled"
  }
}