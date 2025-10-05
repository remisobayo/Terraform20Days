
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


/*
provider "aws" {
  region = "eu-west-1"
}
*/

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "replication" {
  name               = "tf-iam-role-replication-12345"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "replication" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]

    resources = [aws_s3_bucket.wordpress_bucket.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]

    resources = ["${aws_s3_bucket.wordpress_bucket.arn}/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = ["${aws_s3_bucket.destination_bucket.arn}/*"]
  }
}

resource "aws_iam_policy" "replication" {
  name   = "tf-iam-role-policy-replication-12345"
  policy = data.aws_iam_policy_document.replication.json
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

/*
resource "aws_s3_bucket" "destination" {
  bucket = "tf-test-bucket-destination-12345"
}

resource "aws_s3_bucket" "source" {
  region = var.aws_region

  bucket = "tf-test-bucket-source-12345"
}

resource "aws_s3_bucket_acl" "source_bucket_acl" {
  region = "eu-central-1"

  bucket = aws_s3_bucket.source.id
  acl    = "private"
}
*/

resource "aws_s3_bucket_versioning" "destination" {
  bucket = aws_s3_bucket.destination_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "source" {
  # region = "eu-central-1"

  bucket = aws_s3_bucket.wordpress_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  # region = "eu-central-1"

  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.source]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.wordpress_bucket.id

  rule {
    id = "examplerule"

    filter {
      prefix = "example"
    }

    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.destination_bucket.arn
      storage_class = "STANDARD"
    }
  }
}