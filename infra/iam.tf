data "aws_iam_policy_document" "lambda_edge_exec" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "write_logs" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [ "arn:aws:logs:*:*:*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "xray:PutTraceSegemtns",
      "xray:PutTelemetryRecords"
    ]

    resources = ["*"]
  }
}
resource "aws_iam_policy" "write_logs" {
  name   = "${var.service}_write_logs"
  policy = data.aws_iam_policy_document.write_logs.json
}