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

  dynamic "ingress" {
    iterator = port
    for_each = {
      80 = "0.0.0.0/0"
      443 = "2.2.2.2/32"
      22 = "0.0.0.0/0"

    }
    content {
      from_port   = port.key
      to_port     = port.key
      protocol    = "tcp"
      cidr_blocks = [port.value]
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}