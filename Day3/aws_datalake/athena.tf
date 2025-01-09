resource "aws_athena_workgroup" "nba_analytics_output" {
  name = "nba_analytics"

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.day3.bucket}/athena-results"
    }
  }
}

resource "aws_athena_named_query" "test-query" {
  name      = "EXAMPLE-QUERY"
  workgroup = aws_athena_workgroup.nba_analytics_output.id
  database  = aws_glue_catalog_database.day3.name
  query     = "SELECT * FROM ${aws_glue_catalog_database.day3.name}.${aws_glue_catalog_table.nba_players_table.name} limit 10;"
}

// This query will need to be run to allow terraform destroy to work properly.
resource "aws_athena_named_query" "clear-cache" {
  name      = "CLEAR"
  workgroup = aws_athena_workgroup.nba_analytics_output.id
  database  = aws_glue_catalog_database.day3.name
  query     = "DROP DATABASE ${aws_glue_catalog_database.day3.name} CASCADE"
}