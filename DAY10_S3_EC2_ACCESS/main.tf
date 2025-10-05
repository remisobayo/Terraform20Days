
resource aws_s3_bucket "wordpress-bucket" {
    bucket = var.KKE_BUCKET_NAME
}

resource aws_instance "wordpress-ec2" {
    ami = data.aws_ami.amazon_linux_2_latest.id
    instance_type = "t2.micro"
    iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name
    
    tags = {
        Name = "xfusion-ec2"
      }


}

resource "aws_iam_policy" "s3_access_policy" {
    name        = var.KKE_POLICY_NAME
    description = "Policy to grant EC2 instance read/write access to a specific S3 bucket"

    policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
        Effect = "Allow",
        Action = [
            "s3:PutObject"
        ],
        Resource = [
            "arn:aws:s3:::${var.KKE_BUCKET_NAME}",
            "arn:aws:s3:::${var.KKE_BUCKET_NAME}/*"
        ]
        }
    ]
    })
}


resource "aws_iam_role" "ec2_s3_role" {
    name               = var.KKE_ROLE_NAME
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
          {
            Effect = "Allow",
            Principal = {
              Service = "ec2.amazonaws.com"
            },
            Action = "sts:AssumeRole"
          }
        ]
      })
    }


resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
    role       = aws_iam_role.ec2_s3_role.name
    policy_arn = aws_iam_policy.s3_access_policy.arn
}


resource "aws_iam_instance_profile" "ec2_s3_profile" {
    name = "ec2-s3-profile"
    role = aws_iam_role.ec2_s3_role.name
}