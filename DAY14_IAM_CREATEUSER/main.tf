
resource "aws_iam_user" "user" {
  name = var.KKE_USER_NAME
#   path = "/system/"

    provisioner "local-exec" {
        command = "echo 'KKE iamuser_ammar has been created successfully!' >> ./KKE_user_created.log"
  }
}

/*
resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.user.name
}

data "aws_iam_policy_document" "lb_ro" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "lb_ro" {
  name   = "test"
  user   = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.lb_ro.json
}
*/