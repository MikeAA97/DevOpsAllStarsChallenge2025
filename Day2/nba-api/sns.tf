resource "aws_sns_topic" "nba-api" {
  name = var.sns_name
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.nba-api.arn
  protocol  = "email"
  endpoint  = var.email_address
}