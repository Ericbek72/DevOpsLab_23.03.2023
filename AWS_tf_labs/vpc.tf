resource "aws_vpc" "lab-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "TF-LAB-VPC"
  }
}

resource "aws_internet_gateway" "vpc-gateway" {
  vpc_id = aws_vpc.lab-vpc.id

  tags = {
    Name  = "VPC IGW"
    Owner = "erkin"
  }
  depends_on = [aws_vpc.lab-vpc] # depends_on tells Terraform to complete the aws_vpc.my-vpc resource creation first before starting this one
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.lab-vpc.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones_public, count.index)
  tags = {
    Name  = "VPC Public Subnet ${count.index + 1}"
    Owner = "erkin"
  }
  depends_on = [aws_vpc.lab-vpc]
}

# resource "aws_subnet" "public_subnet_2" {
#   vpc_id            = aws_vpc.lab-vpc.id
#   cidr_block        = var.public_subnet_2_cidr
#   availability_zone = var.availability_zone_public_2
#   tags = {
#     Name  = "VPC Private Subnet-2"
#     Owner = "erkin"
#   }
#   depends_on = [aws_vpc.lab-vpc]
# }

resource "aws_default_route_table" "route_table" {
  default_route_table_id = aws_vpc.lab-vpc.main_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-gateway.id
  }

  tags = {
    Name = "Route to Internet"
  }
  depends_on = [aws_vpc.lab-vpc]
}

resource "aws_route_table_association" "public_subnet_asso" {
  count          = 2
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_vpc.lab-vpc.main_route_table_id
}

# resource "aws_route_table_association" "public_subnet_2_asso" {
#   subnet_id = aws_subnet.public_subnet_2.id
#   route_table_id = aws_vpc.lab-vpc.main_route_table_id
# }
