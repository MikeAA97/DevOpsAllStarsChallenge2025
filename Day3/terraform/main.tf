module "day3" {
  source = "../aws_datalake"

  datalake_bucket_name = var.datalake_bucket_name
  nba_api_token        = var.nba_api_token
}