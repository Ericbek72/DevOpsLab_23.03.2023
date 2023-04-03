resource "aws_security_group" "allow_ssh_and_http" {
  name        = "allow_ssh_and_http"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.lab-vpc.id

  ingress {
    description = "Allow SSH for VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 semantically equivalent to "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner = "erkin"
    Name  = "allow_ssh_and_http"
  }
}
