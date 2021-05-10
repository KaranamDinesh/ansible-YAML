resource "null_resource" "nothing" {
  depends_on = [aws_instance.sample]
}

resource "aws_instance" "sample" {
  count = 2
  ami = "ami-079a3f3cf00741286"
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
}
provider "aws" {
  region = "us-east-1"
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [0.0.0.0/0]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}