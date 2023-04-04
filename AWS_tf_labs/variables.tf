variable "new_EC2" {
  description = "Instance type"
  type        = string
}

variable "key_pair_name" {
  description = "Name for the SSH key pair"
  type        = string
}

variable "vpc_cidr" {
  description = "IP CIDR range for the VPC"
  type        = string
}

variable "availability_zones_public" {
  description = "us-east-1a AZ cidrs"
  type        = list(string)
}

variable "public_subnet_cidrs" {

  type = list(string)
}

# variable "users" {
#   type = object({
#     name = list(string)
#     uid_number  = set(number)
#   })
# }


