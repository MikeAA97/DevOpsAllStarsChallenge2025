module "nba-api" {
  source = "../nba-api"

  sns_name      = "my_custom_name"
  region        = "us-east-1"
  email_address = var.email_address
  nba_api_token = var.nba_api_token
}