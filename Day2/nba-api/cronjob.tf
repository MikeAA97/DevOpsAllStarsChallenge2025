resource "aws_cloudwatch_event_rule" "cron_job" {
  name                = "nba-api"
  description         = "Runs every 2 hours Monday through Friday between 10 AM and 2 PM EST"
  schedule_expression = "cron(0 15,17,19 ? * 2-6 *)"
}

resource "aws_cloudwatch_event_target" "nba_lambda" {
  rule = aws_cloudwatch_event_rule.cron_job.name
  arn  = aws_lambda_function.nba_lambda.arn
}

resource "aws_lambda_permission" "cronjob" {
  statement_id  = "AllowEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.nba_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cron_job.arn
}