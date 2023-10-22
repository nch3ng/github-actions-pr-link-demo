data "archive_file" "origin_archive" {
  type        = "zip"
  output_path = "${path.module}/.dist/origin-request.zip"
  source_dir  = "${path.module}/../.dist/origin-request"
}

resource "aws_lambda_function" "lambda_origin_request" {
  provider = aws.us_east_provider
  publish  = true

  filename         = "${path.module}/.dist/origin-request.zip"
  function_name    = "${var.service}-lambdas-origin-request"
  role             = aws_iam_role.lambda_origin_request.arn
  source_code_hash = "${path.module}/.dist/origin-request.zip.sha256"
  handler          = "index.handler"
  runtime          = "nodejs18.x"
}

resource "aws_iam_role" "lambda_origin_request" {
  name               = "${var.service}-lambdas-origin-request-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_edge_exec.json
}

resource "aws_iam_role_policy_attachment" "lambda_origin_write_logs" {
  role       = aws_iam_role.lambda_origin_request.name
  policy_arn = aws_iam_policy.write_logs.arn
}