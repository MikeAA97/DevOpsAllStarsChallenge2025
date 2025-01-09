variable "datalake_bucket_name" {
  type        = string
  description = "Name of S3 Bucket to hold API Dataset"
}

variable "region" {
  type        = string
  description = "Region to deploy resources in."
  default     = "us-east-1"
}

variable "nba_api_token" {
  type        = string
  description = "API Token from the sportsdata.io"
}