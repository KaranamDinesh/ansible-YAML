resource "null_resource" "nothing" {
  //depends_on = [aws_instance.sample]
}

resource "aws_instance" "sample" {
  ami = "ami-0ed9d2e6b42fd9de7"
  instance_type = "t2.micro"

  }