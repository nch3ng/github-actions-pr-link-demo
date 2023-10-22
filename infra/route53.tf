data aws_route53_zone "app" {
  name = "${var.root_domain_name}"
}

resource aws_route53_record "app" {
  zone_id = data.aws_route53_zone.app.zone_id
  name    = "${var.service}.natecheng.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "pr-demo" {
  depends_on = [data.aws_route53_zone.app, resource.aws_acm_certificate.pr-demo]
  for_each = {
    for dvo in aws_acm_certificate.pr-demo.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.app.zone_id
}

resource "aws_route53_record" "test" {
  depends_on = [data.aws_route53_zone.app, resource.aws_acm_certificate.test]
  for_each = {
    for dvo in aws_acm_certificate.test.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.app.zone_id
}