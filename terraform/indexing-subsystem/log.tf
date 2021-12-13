resource "aws_cloudwatch_log_group" "uploader_log_group" {
  name              = "/aws/lambda/${local.uploader_lambda.name}"
  retention_in_days = 14
}

resource "aws_iam_policy" "uploader_lambda_logging" {
  name        = "${local.uploader_lambda.name}_lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "uploader_lambda_logs" {
  role       = aws_iam_role.uploader_lambda_role.name # Change this
  policy_arn = aws_iam_policy.uploader_lambda_logging.arn
}