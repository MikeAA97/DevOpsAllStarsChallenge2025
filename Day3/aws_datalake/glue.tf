
resource "aws_glue_catalog_database" "day3" {
  name = "day3_allstar_challenge"
}

resource "aws_glue_catalog_table" "nba_players_table" {
  database_name = aws_glue_catalog_database.day3.name
  name          = "nba_players"

  table_type = "EXTERNAL_TABLE"

  storage_descriptor {
    columns {
      name = "playerid"
      type = "int"
    }
    columns {
      name = "firstname"
      type = "string"
    }
    columns {
      name = "lastname"
      type = "string"
    }
    columns {
      name = "team"
      type = "string"
    }
    columns {
      name = "position"
      type = "string"
    }
    columns {
      name = "points"
      type = "int"
    }

    location      = "s3://${var.datalake_bucket_name}/raw-data/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }
  }
}