
resource "aws_vpc" "network" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_eip" "natEIP" {
  vpc = true
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.network.id
  cidr_block = var.public_cidr

  tags = {
    Name = "public-subnet"
  }

  depends_on = [
    aws_vpc.network,
  ]
}

resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.network.id
  cidr_block = var.private_cidr

  tags = {
    Name = "private-subnet"
  }

  depends_on = [
    aws_vpc.network,
  ]
}

resource "aws_subnet" "private-failover-subnet" {
  vpc_id = aws_vpc.network.id
  cidr_block = var.private_failover_cidr

  tags = {
    Name = "private-failover-subnet"
  }

  depends_on = [
    aws_vpc.network,
  ]
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.network.id

  depends_on = [
    aws_vpc.network,
  ]
}

resource "aws_nat_gateway" "NATGW" {
  allocation_id = aws_eip.natEIP.id
  subnet_id = aws_subnet.public-subnet.id

  depends_on = [
    aws_vpc.network,
    aws_subnet.public-subnet,
  ]
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.network.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  depends_on = [
    aws_vpc.network,
    aws_internet_gateway.IGW,
  ]
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.network.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NATGW.id
  }
  
  depends_on = [
    aws_vpc.network
    aws_nat_gateway.NATGW,
  ]
}

resource "aws_route_table_association" "public-rt-association" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
  
  depends_on = [
    aws_subnet.public-subnet,
    aws_route_table.public-rt,
  ]
}

resource "aws_route_table_association" "private-rt-association" {
  subnet_id = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id

  depends_on = [
    aws_subnet.private-subnet,
    aws_route_table.private-rt,
  ]
}

