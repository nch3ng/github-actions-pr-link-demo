output "s3_arn" {
  value = resource.aws_s3_bucket.app.arn
}

output "cloudfront_arn" {
  value = resource.aws_cloudfront_distribution.s3_distribution.arn
}

output "certificate" {
  value = resource.aws_acm_certificate.cert_app.arn
}
