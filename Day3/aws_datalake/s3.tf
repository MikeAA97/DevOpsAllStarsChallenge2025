resource "aws_s3_bucket" "day3" {
  bucket = var.datalake_bucket_name

  force_destroy = true

  tags = {
    Purpose = "DevOpsAllStarChallenge"
  }
}