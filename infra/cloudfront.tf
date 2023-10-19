resource "aws_cloudfront_distribution" "s3_distribution" {
  depends_on = [
    aws_s3_bucket.app,
    data.aws_acm_certificate.app,
    aws_cloudfront_origin_access_control.s3_app_oac
  ]

  origin {
    domain_name              = aws_s3_bucket.app.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_app_oac.id
    origin_id                = aws_s3_bucket.app.id
    origin_path              = "/current"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "The demo link for PR workflow"
  default_root_object = "index.html"

  aliases = ["${var.service}.${var.root_domain_name}", "*.${var.service}.${var.root_domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.app.id

    forwarded_values {
      query_string = false

      cookies {
        forward           = "whitelist"
        whitelisted_names = ["pr-id"]
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "MX"]
    }
  }

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 403
    response_code         = 403
    response_page_path    = "/index.html"
  }

  viewer_certificate {
    # cloudfront_default_certificate = true
    acm_certificate_arn      = data.aws_acm_certificate.app.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_control" "s3_app_oac" {
  name                              = aws_s3_bucket.app.bucket_regional_domain_name
  description                       = ""
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
