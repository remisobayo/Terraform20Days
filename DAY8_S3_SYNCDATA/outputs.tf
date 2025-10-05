

output "new_kke_bucket_name" {
    value = aws_s3_bucket.destination_bucket.id

}

output "new_kke_bucket_acl" {
    value = aws_s3_bucket_acl.destination_bucket_acl.acl

}