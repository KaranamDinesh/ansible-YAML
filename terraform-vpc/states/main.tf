resource "aws_subnet" "private-subnets" {
  count               = length(var.PRIVATE_SUBNETS)
  cidr_block          = element(var.PRIVATE_SUBNETS, count.index)
  vpc_id              = aws_vpc.main.id
  availability_zone   = element(data.aws_availability_zones.available.names, count.index)
  tags                = {
    Name              = "private-subnet-${count.index+1}"
    Environment       = var.ENV
  }

resource "aws_subnet" "public-subnets" {
  count               = length(var.PUBLIC_SUBNETS)
  cidr_block          = element(var.PUBLIC_SUBNETS, count.index)
  vpc_id              = aws_vpc.main.id
  availability_zone   = element(data.aws_availability_zones.available.names, count.index)
  tags                = {
    Name              = "public-subnet-${count.index+1}"
    Environment       = var.ENV
  }
