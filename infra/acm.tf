data "aws_acm_certificate" "app" {
  domain   = "${var.root_domain_name}"
  statuses = ["ISSUED"]
  key_types = ["RSA_2048","EC_prime256v1"]
  provider = aws.us_east_provider
}