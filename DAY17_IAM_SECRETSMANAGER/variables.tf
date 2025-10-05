
variable "KKE_SECRET_NAME" {
  description = "the secret name."
  type = string
}

variable "KKE_SECRET_VALUE" {
  description = "the secret value"
  type = string
}

variable "KKE_ROLE_NAME" {
  description = "The IAM role name."
  type = string
}

variable "KKE_POLICY_NAME" {
  description = "the IAM policy name."
  type = string
}