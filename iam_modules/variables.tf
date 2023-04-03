variable "group_name" {
  type = string
}

variable "group_users" {
  type = list(string)
}

variable "aws_account_id" {
  description = "AWS account id to use inside IAM policies. If empty, current AWS account ID will be used."
  type        = string
  default     = ""
}

variable "enable_mfa_enforcment" {
  description = "Determines whether permissions are added to the policy which requires the groups IAM users to use MFA"
  type        = bool
  default     = true 
}