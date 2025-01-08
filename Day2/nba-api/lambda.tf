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
  function_name = "day2"
  role          = aws_iam_role.nba_lambda_role.arn
  handler       = "nba.lambda_handler"

  runtime = "python3.11"

  environment {
    variables = {
      NBA_API_KEY   = var.nba_api_token
      SNS_TOPIC_ARN = aws_sns_topic.nba-api.arn
    }
  }
}
