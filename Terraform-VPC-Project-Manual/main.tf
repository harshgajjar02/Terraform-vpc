provider "aws" {
  region = "us-east-1"
}


#--------------------------------------------------------
#  VPC

resource "aws_vpc" "network-demo-vpc" {
  cidr_block                       = "10.19.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  assign_generated_ipv6_cidr_block = true
  tags = {
    "name" : "network-demo-vpc"
  }
}


#--------------------------------------------------------
# subnet creation
# AZS us-east-1a us-east-1b us-east-1c


#-------------us-east-1a----------------------------------

resource "aws_subnet" "sn-web-A" {
  vpc_id                  = aws_vpc.network-demo-vpc.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.19.0.0/20"
  map_public_ip_on_launch = true

  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 1)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-web-A"
  }
}

resource "aws_subnet" "sn-app-A" {
  vpc_id            = aws_vpc.network-demo-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.19.16.0/20"


  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 2)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-app-A"
  }
}

resource "aws_subnet" "sn-db-A" {
  vpc_id            = aws_vpc.network-demo-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.19.32.0/20"


  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 3)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-db-A"
  }
}

resource "aws_subnet" "sn-reserved-A" {
  vpc_id            = aws_vpc.network-demo-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.19.48.0/20"


  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 4)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-reserved-A"
  }
}



#------------us-east-1b---------------------------------


resource "aws_subnet" "sn-web-B" {
  vpc_id                  = aws_vpc.network-demo-vpc.id
  availability_zone       = "us-east-1b"
  cidr_block              = "10.19.64.0/20"
  map_public_ip_on_launch = true

  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 5)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-web-B"
  }
}

resource "aws_subnet" "sn-app-B" {
  vpc_id            = aws_vpc.network-demo-vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.19.80.0/20"


  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 6)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-app-B"
  }
}

resource "aws_subnet" "sn-db-B" {
  vpc_id            = aws_vpc.network-demo-vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.19.96.0/20"


  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 7)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-db-B"
  }
}

resource "aws_subnet" "sn-reserved-B" {
  vpc_id            = aws_vpc.network-demo-vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.19.112.0/20"


  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 8)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-reserved-B"
  }
}


#------------us-east-1c---------------------------------


resource "aws_subnet" "sn-web-C" {
  vpc_id                  = aws_vpc.network-demo-vpc.id
  availability_zone       = "us-east-1c"
  cidr_block              = "10.19.128.0/20"
  map_public_ip_on_launch = true

  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 9)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-web-C"
  }
}

resource "aws_subnet" "sn-app-C" {
  vpc_id            = aws_vpc.network-demo-vpc.id
  availability_zone = "us-east-1c"
  cidr_block        = "10.19.144.0/20"


  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 10)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-app-C"
  }
}

resource "aws_subnet" "sn-db-C" {
  vpc_id            = aws_vpc.network-demo-vpc.id
  availability_zone = "us-east-1c"
  cidr_block        = "10.19.160.0/20"


  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 11)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-db-C"
  }
}

resource "aws_subnet" "sn-reserved-C" {
  vpc_id            = aws_vpc.network-demo-vpc.id
  availability_zone = "us-east-1c"
  cidr_block        = "10.19.176.0/20"


  ipv6_cidr_block                 = cidrsubnet(aws_vpc.network-demo-vpc.ipv6_cidr_block, 8, 12)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "sn-reserved-C"
  }
}


#-------------internet gateway -------------------------

resource "aws_internet_gateway" "network-demo-igw" {
  vpc_id = aws_vpc.network-demo-vpc.id

  tags = {
    Name = "network-demo-igw"
  }
}
#-------------Elastic IP -------------------------------

resource "aws_eip" "nat-eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.network-demo-igw]
  tags = {
    Name = "nat-eip"
  }
}

#------------- NAT gateway -----------------------------

resource "aws_nat_gateway" "network-demo-nat" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.sn-web-A.id
  depends_on    = [aws_internet_gateway.network-demo-igw]
  tags = {
    Name = "network-demo-nat"
  }
}


#-------------route Tables-------------------------------

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.network-demo-vpc.id

  route {
    cidr_block = aws_vpc.network-demo-vpc.cidr_block
    gateway_id = "local"
  }

  route {
    ipv6_cidr_block = aws_vpc.network-demo-vpc.ipv6_cidr_block
    gateway_id      = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.network-demo-igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.network-demo-igw.id
  }
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.network-demo-vpc.id

  route {
    cidr_block = aws_vpc.network-demo-vpc.cidr_block
    gateway_id = "local"
  }

  route {
    ipv6_cidr_block = aws_vpc.network-demo-vpc.ipv6_cidr_block
    gateway_id      = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.network-demo-nat.id
  }

  tags = {
    Name = "private-rt"
  }
}


#--------------route Table Associations -----------------

#-----public subnet associations ---------

resource "aws_route_table_association" "pub-assoc-webA" {
  subnet_id = aws_subnet.sn-web-A.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "pub-assoc-webB" {
  subnet_id = aws_subnet.sn-web-B.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "pub-assoc-webC" {
  subnet_id = aws_subnet.sn-web-C.id
  route_table_id = aws_route_table.public-rt.id
}

#-----private subnet associations ---------
#-------------app--------------------------

resource "aws_route_table_association" "pvt-assoc-appA" {
  subnet_id = aws_subnet.sn-app-A.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "pvt-assoc-appB" {
  subnet_id = aws_subnet.sn-app-B.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "pvt-assoc-appC" {
  subnet_id = aws_subnet.sn-app-C.id
  route_table_id = aws_route_table.private-rt.id
}

#-------------db--------------------------

resource "aws_route_table_association" "pvt-assoc-dbA" {
  subnet_id = aws_subnet.sn-db-A.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "pvt-assoc-dbB" {
  subnet_id = aws_subnet.sn-db-B.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "pvt-assoc-dbC" {
  subnet_id = aws_subnet.sn-db-C.id
  route_table_id = aws_route_table.private-rt.id
}

#-------------reserved--------------------------

resource "aws_route_table_association" "pvt-assoc-reservedA" {
  subnet_id = aws_subnet.sn-reserved-A.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "pvt-assoc-reservedB" {
  subnet_id = aws_subnet.sn-reserved-B.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "pvt-assoc-reservedC" {
  subnet_id = aws_subnet.sn-reserved-C.id
  route_table_id = aws_route_table.private-rt.id
}



# creating an instance in this env

resource "aws_security_group" "test-sg" {
  name   = "test-sg"
  vpc_id = aws_vpc.network-demo-vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test-sg"
  }
}

resource "aws_instance" "name" {
  ami             = "ami-04b70fa74e45c3917"
  instance_type   = "t2.micro"
  subnet_id = aws_subnet.sn-web-A.id
  vpc_security_group_ids  = [aws_security_group.test-sg.id]
  key_name        = "test-key"
}