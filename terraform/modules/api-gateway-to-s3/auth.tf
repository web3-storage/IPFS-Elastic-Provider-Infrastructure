resource "aws_iam_policy" "s3_policy" {
  name        = "s3-policy"
  tags        = {}
  description = "Policy for allowing all S3 Actions"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.bucketName}/*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "s3_api_gateyway_role" {
  name = "s3-api-gateyway-role"
  tags = {}

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
} 
EOF
}

resource "aws_iam_role_policy_attachment" "s3_policy_attach" {
  role       = aws_iam_role.s3_api_gateyway_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}


