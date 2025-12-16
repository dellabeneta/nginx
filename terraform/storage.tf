resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "app_bucket" {
  bucket        = "nginx-app-deploy-${random_id.bucket_suffix.hex}"
  force_destroy = true

  tags = local.common_tags
}

resource "aws_s3_object" "app_files" {
  for_each = fileset("../app", "**/*")

  bucket = aws_s3_bucket.app_bucket.id
  key    = each.value
  source = "../app/${each.value}"
  etag   = filemd5("../app/${each.value}")
}
