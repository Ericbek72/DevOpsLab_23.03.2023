resource "tls_private_key" "tls_connector" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tf_ec2_public_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.tls_connector.public_key_openssh

  tags = {
    Owner = "erkin"
  }
}

resource "local_file" "tf_ec2_private_key_file" {
  content  = tls_private_key.tls_connector.private_key_pem
  filename = "tf_ec2_private_key.pem"
}

/*data "aws_ami" "amazon-EC2-apache" {

  owners = ["self"]

  filter {
    name   = "name"
    values = ["*Apache*"]
  }
}*/


# Create a EC2 instance
resource "aws_instance" "EC2_lab" {
  ami           = "ami-00c39f71452c08778"
  instance_type = var.new_EC2
  key_name      = aws_key_pair.tf_ec2_public_key.id
  count         = length(var.public_subnet_cidrs)
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)

  associate_public_ip_address = true
  security_groups             = [aws_security_group.allow_ssh_and_http.id]
  tags = {
    Name  = "EC2 for VPC ${count.index + 1}"
    Owner = "erkin"
  }
}

resource "aws_ebs_volume" "demo_volume" {
  size              = 1
  count         = length(var.public_subnet_cidrs)
  availability_zone = var.availability_zones_public[0]
  type              = "standard"
}
resource "aws_volume_attachment" "attach_demo_volume" {
  count             = length(var.public_subnet_cidrs)
  device_name  = "/dev/sdb"
  volume_id    = aws_ebs_volume.demo_volume[0].id
  instance_id  = aws_instance.EC2_lab[0].id
  skip_destroy = true
}

# resource "aws_ebs_volume" "lab_vol" {
#   availability_zone = "us-east-1b"
#   size              = 1

#   tags = {
#     Name = "lab_vg"
#   }
# }

# resource "aws_volume_attachment" "attach_demo_volume" {
#   device_name  = "/dev/sdc"
#   volume_id    = aws_ebs_volume.lab_vol.id
#   count        = length(var.public_subnet_cidrs)
#   instance_id  = element(aws_instance.EC2_lab[1].id, count.index)
#   skip_destroy = true
# }