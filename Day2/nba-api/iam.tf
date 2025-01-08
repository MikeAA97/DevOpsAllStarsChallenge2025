data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "sns_publish_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sns:Publish"
    ]

    resources = [
      "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.sns_name}"
    ]
  }
}

resource "aws_iam_policy" "sns_publish_policy" {
  name   = "sns_publsh_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.sns_publish_policy.json
}

resource "aws_iam_role" "nba_lambda_role" {
  name               = "nba_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy_attachment" "sns-policy-attach" {
  role       = aws_iam_role.nba_lambda_role.name
  policy_arn = aws_iam_policy.sns_publish_policy.arn
}
