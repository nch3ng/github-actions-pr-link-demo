data "archive_file" "viewer_archive" {
  type        = "zip"
  output_path = "${path.module}/.dist/viewer-request.zip"
  source_dir  = "${path.module}/../.dist/viewer-request"
}

resource "aws_lambda_function" "lambda_viewer_request" {
  provider = aws.us_east_provider
  publish  = true

  filename         = "${path.module}/.dist/viewer-request.zip"
  function_name    = "${var.service}-lambdas-viewer-request"
  role             = aws_iam_role.lambda_viewer_request.arn
  source_code_hash = "${path.module}/.dist/viewer-request.zip.sha256"
  handler          = "index.handler"
  runtime          = "nodejs18.x"
}


resource "aws_iam_role" "lambda_viewer_request" {
  name               = "${var.service}-lambdas-viewer-request-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_edge_exec.json
}

resource "aws_iam_role_policy_attachment" "lambda_viewer_write_logs" {
  role       = aws_iam_role.lambda_viewer_request.name
  policy_arn = aws_iam_policy.write_logs.arn
}