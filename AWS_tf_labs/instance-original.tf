/*resource "tls_private_key" "tls_connector" {
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

data "aws_ami" "amazon-EC2-apache" {

  owners = ["self"]

  filter {
    name   = "name"
    values = ["*Apache*"]
  }
}

# Create a EC2 instance
resource "aws_instance" "First_EC2_lab" {
  ami           = data.aws_ami.amazon-EC2-apache.id
  instance_type = var.new_EC2
  key_name      = aws_key_pair.tf_ec2_public_key.id
  subnet_id     = aws_subnet.public_subnet_1.id

  associate_public_ip_address = true
  security_groups             = [aws_security_group.allow_ssh_and_http.id]
  tags = {
    Name  = "1st_EC2 for VPC"
    Owner = "erkin"
  }
}

resource "aws_instance" "Second_EC2_lab" {
  ami           = data.aws_ami.amazon-EC2-apache.id
  instance_type = var.new_EC2
  key_name      = aws_key_pair.tf_ec2_public_key.id
  subnet_id     = aws_subnet.public_subnet_2.id

  associate_public_ip_address = true
  security_groups             = [aws_security_group.allow_ssh_and_http.id]
  tags = {
    Name  = "2nd_EC2 for VPC"
    Owner = "erkin"
  }
}
*/
