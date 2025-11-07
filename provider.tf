provider "aws" {
  region = "ap-south-1"

}


resource "aws_internet_gateway" "igwp" {
  vpc_id = aws_vpc.prvn.id
  tags = {
    Name = "igep"
    Env  = "Dev"
  }
  depends_on = [aws_vpc.prvn]

}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.prvn.id
  tags = {
    Name = "private"
    Env  = "Dev"
  }
  depends_on = [aws_subnet.app, aws_subnet.db]

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.prvn.id
  tags = {
    Name = "public"
    Env  = "Dev"
  }
  depends_on = [aws_internet_gateway.igwp, aws_subnet.web]

}

resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.igwp.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_internet_gateway.igwp, aws_route_table.public]

}

resource "aws_route_table_association" "public_web" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.web.id

}

resource "aws_route_table_association" "private_app" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.app.id

}
resource "aws_route_table_association" "provate_db" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.db.id

}