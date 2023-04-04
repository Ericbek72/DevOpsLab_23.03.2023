vpc_cidr                  = "192.168.0.0/16"
availability_zones_public = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs       = ["192.168.1.0/24", "192.168.2.0/24"]
# availability_zone_public_2 = "us-east-1b"
#public_subnet_2_cidr       = "192.168.2.0/24"
key_pair_name = "terraform_ec2_key"
new_EC2       = "t2.micro"

# users = {
#   name = ["john", "davis"]
#   uid_number  = [2000, 3000]
# }