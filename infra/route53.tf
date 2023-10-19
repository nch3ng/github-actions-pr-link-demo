data aws_route53_zone "app" {
  name = "${var.root_domain_name}"
}

resource aws_route53_record "app" {
  zone_id = data.aws_route53_zone.app.zone_id
  name    = "${var.service}.${var.root_domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}