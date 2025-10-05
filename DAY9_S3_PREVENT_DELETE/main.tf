# source bucket
resource "aws_s3_bucket" "wordpress_bucket" {
  bucket = var.KKE_BUCKET_NAME

  lifecycle {
    prevent_destroy = true

  }

}