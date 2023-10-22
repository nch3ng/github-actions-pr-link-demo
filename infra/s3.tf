resource "aws_s3_bucket" "app" {
  bucket = var.service
}

resource "aws_s3_bucket_ownership_controls" "app-ownership" {
  bucket = aws_s3_bucket.app.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "app-acl" {
  depends_on = [aws_s3_bucket.app, aws_s3_bucket_ownership_controls.app-ownership]
  bucket     = aws_s3_bucket.app.id
  acl        = "private"
}

resource "aws_s3_bucket_versioning" "app-versioning" {
  bucket = aws_s3_bucket.app.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_website_configuration" "app-website" {
  bucket = aws_s3_bucket.app.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "s3_distribution_access" {
  bucket = aws_s3_bucket.app.id
  policy = data.aws_iam_policy_document.s3_distribution_access.json
}

data "aws_iam_policy_document" "s3_distribution_access" {
  depends_on = [aws_cloudfront_distribution.s3_distribution]
  statement {
    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.app.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}