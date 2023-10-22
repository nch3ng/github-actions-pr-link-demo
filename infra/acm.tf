data "aws_acm_certificate" "app" {
  domain   = "${var.root_domain_name}"
  statuses = ["ISSUED"]
  key_types = ["RSA_2048","EC_prime256v1"]
  provider = aws.us_east_provider
}

resource "aws_acm_certificate" "pr-demo" {
  provider = aws.us_east_provider
  // We want a wildcard cert so we can host subdomains later.
  domain_name               = "pr-demo.${var.root_domain_name}"
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "pr-demo" {
  provider                = aws.us_east_provider
  certificate_arn         = aws_acm_certificate.pr-demo.arn
  validation_record_fqdns = [for record in aws_route53_record.pr-demo : record.fqdn]
}


resource "aws_acm_certificate" "test" {
  provider = aws.us_east_provider
  // We want a wildcard cert so we can host subdomains later.
  domain_name               = "test.${var.root_domain_name}"
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "test" {
  provider                = aws.us_east_provider
  certificate_arn         = aws_acm_certificate.test.arn
  validation_record_fqdns = [for record in aws_route53_record.test : record.fqdn]
}