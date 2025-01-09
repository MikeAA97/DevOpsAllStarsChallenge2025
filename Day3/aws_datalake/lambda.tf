data "archive_file" "nba_lambda" {
  type        = "zip"
  output_path = "${path.module}/files/nba.zip"

  source {
    content  = file("${path.module}/src/nba.py")
    filename = "nba.py"
  }
}

resource "aws_lambda_function" "nba_lambda" {
  filename      = data.archive_file.nba_lambda.output_path
  function_name = "day3"
  role          = aws_iam_role.nba_lambda_role.arn
  handler       = "nba.lambda_handler"

  runtime = "python3.11"
  timeout = 10
  environment {
    variables = {
      NBA_API_KEY  = var.nba_api_token
      NBA_ENDPOINT = "https://api.sportsdata.io/v3/nba/scores/json/Players"
      S3_BUCKET    = var.datalake_bucket_name
    }
  }
}


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

resource "aws_iam_role" "nba_lambda_role" {
  name               = "nba_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "aws_iam_policy_document" "lambda_s3_putobject_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.day3.arn}",
      "${aws_s3_bucket.day3.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "lambda_s3_putobject_policy" {
  name   = "lambda_s3_putobject_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_s3_putobject_policy.json
}


resource "aws_iam_role_policy_attachment" "lambda_s3_putobject_policy_attach" {
  role       = aws_iam_role.nba_lambda_role.name
  policy_arn = aws_iam_policy.lambda_s3_putobject_policy.arn
}