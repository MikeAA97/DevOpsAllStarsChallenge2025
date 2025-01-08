variable "sns_name" {
  type        = string
  default     = "nba-api"
  description = "Name for SNS Topic"
}

variable "email_address" {
  type        = string
  description = "Email Address for SNS to send updates to."
}

variable "region" {
  type        = string
  description = "Region to deploy resources and optionally save state file."
}

variable "nba_api_token" {
  type        = string
  description = "API Token from the sportsdata.io"
}