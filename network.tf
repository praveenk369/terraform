resource "aws_vpc" "prvn" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "joy"
    Env  = "Dev"
  }

}
resource "aws_subnet" "web" {
  vpc_id     = aws_vpc.prvn.id
  cidr_block = "192.168.0.0/24"
  tags = {
    Name = "web"
    Env  = "Dev"
  }
  depends_on = [aws_vpc.prvn]

}

resource "aws_subnet" "app" {
  vpc_id     = aws_vpc.prvn.id
  cidr_block = "192.168.1.0/24"
  tags = {
    Name = "app"
    Env  = "Dev"
  }
  depends_on = [aws_vpc.prvn]

}
resource "aws_subnet" "db" {
  vpc_id     = aws_vpc.prvn.id
  cidr_block = "192.168.2.0/24"
  tags = {
    Name = "db"
    Env  = "Dev"
  }
  depends_on = [aws_vpc.prvn]

}
