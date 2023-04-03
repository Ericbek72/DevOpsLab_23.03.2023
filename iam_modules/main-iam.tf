resource "aws_iam_group" "devops_engineers" {
  name = var.group_name
}

resource "aws_iam_group_membership" "devops_engineers_members" {
  name = var.group_name

  users = var.group_users

#   users = [
#     aws_iam_user.user_one.name
#     # aws_iam_user.user_two.name,
#   ]

  group = aws_iam_group.devops_engineers.name
}

################################
# IAM policy
################################

resource "aws_iam_policy" "iam_self_management" {
  name        = "test_iam_policy"
#   path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy =  data.aws_iam_policy_document.iam_self_management.json
}

################################
# IAM group policy
################################

/*resource "aws_iam_group_policy" "my_devops_policy" {
  name  = "my_devops_team_policy"
  group = aws_iam_group.devops_engineers.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}*/

################################
# IAM group policy attachements
################################

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.devops_engineers.name
  policy_arn = aws_iam_policy.iam_self_management.arn
}


