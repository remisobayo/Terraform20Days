

# source bucket
resource "aws_s3_bucket" "wordpress_bucket" {
  bucket = "devops-s3-13529"
}

resource "aws_s3_bucket_acl" "wordpress_bucket_acl" {
  bucket = aws_s3_bucket.wordpress_bucket.id
  acl    = "private"
}

# new destination bucket
resource "aws_s3_bucket" "destination_bucket" {
  bucket = var.KKE_BUCKET
}

resource "aws_s3_bucket_acl" "destination_bucket_acl" {
  bucket = aws_s3_bucket.destination_bucket.id
  acl    = "private"
}

resource "null_resource" "sync_data" {
    provisioner "local-exec" {
    command = "aws s3 sync s3://${aws_s3_bucket.wordpress_bucket.id} s3://${aws_s3_bucket.destination_bucket.id}"
    }
}


/*
# commands

aws s3 ls s3://datacenter-s3-27027 --recursive --summarize
aws s3 ls s3://datacenter-sync-3411 --recursive --summarize

*/