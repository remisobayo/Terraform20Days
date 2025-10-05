
output "kke_iam_role_name" {
    description = "name of the role created."
    value = aws_iam_role.xfusion_role.name
}


output kke_iam_policy_name {
    description = "name of the policy ceated."
    value = aws_iam_policy.xfusion_policy.name
}