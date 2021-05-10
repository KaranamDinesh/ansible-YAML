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