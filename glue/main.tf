resource "aws_glue_catalog_database" "segment_data_lake_glue_catalog" {
  name        = var.name
  description = var.description
}
