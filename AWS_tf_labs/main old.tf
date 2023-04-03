/*module "iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name          = "devops"
  force_destroy = true

  pgp_key = "keybase:test"

  password_reset_required = false
}

# locals {
#   users = {
#     user_1 = {
#       name     = "john"
#       password = "12345678"
#       uid      = "2000"
#     },
#     user_2 = {
#       name     = "davis"
#       password = "87654321"
#       uid      = "3000"
#     }
#   }
# }

# resource "aws_iam_user" "data-users" {
#   for_each = local.users
#   name     = each.value.name
#   force_destroy = true
#   tags = {
#     uid = each.value.uid
#   }
# }

resource "aws_iam_group" "data-users" {
  name = "data"
}

resource "aws_iam_user" "user-names" {
  for_each = var.users
  name     = each.value.name
  # password = each.value.password
  force_destroy = true
  tags = {
    uid = each.value.uid_number
  }
}

resource "aws_iam_user_login_profile" "data-users-keys" {
  for_each = var.users
  #user     = each.value.name
  user = aws_iam_user.user-names[each.value].name
}

resource "aws_iam_user_group_membership" "data-users-member" {
  for_each = var.users
  user     = aws_iam_user.user-names[each.value].name
  groups = [
    aws_iam_group.data-users.name
  ]
}


output "password" {
  value = { for k, v in aws_iam_user_login_profile.data-users-keys : k => v.encrypted_password }
}

resource "aws_iam_user_policy" "newemp_policy" {
  count  = length(var.users)
  name   = "new_iam_policy"
  user   = element(var.users[*], count.index)
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

module "iam_group" {
  source      = "../iam_modules"
  group_users = ["devops"]
  group_name  = "engineers"
}

module "s3_tfstate" {
  source            = "../s3_module"
  state_file_bucket = "tfstates3backup" # see main.tf from modules
}

resource "aws_db_instance" "devx_db" {
  identifier        = "devx-db-tf"
  allocated_storage = 10
  db_name           = "mysql_db"
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  username          = "devops"
  password          = "abcd1234"
  #parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
  publicly_accessible = true
}*/

