resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  instance_tenancy     = var.latency
  tags = {
    ENV = var.ENV
  }
}

resource "aws_subnet" "private" {
  count             = length(var.cidr_private)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_private[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    type = "private"
    ENV  = var.ENV
  }
}

resource "aws_subnet" "public" {
  count             = length(var.cidr_public)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_public[count.index]
  availability_zone = var.availability_zones[count.index]


  tags = {
    type = "public"
    ENV  = var.ENV
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.ENV}-igw"
    ENV  = var.ENV
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.ENV}-public-rt"
    type = "public"
    ENV  = var.ENV
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.cidr_public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.ENV}-nat-eip"
    ENV  = var.ENV
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.ENV}-nat-gw"
    ENV  = var.ENV
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.ENV}-private-rt"
    type = "private"
    ENV  = var.ENV
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.cidr_private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_db_subnet_group" "db" {
  name       = "${var.ENV}-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "${var.ENV}-db-subnet-group"
    ENV  = var.ENV
  }
}



# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "${var.ENV}-igw"
#     ENV  = var.ENV
#   }
# }

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = {
#     Name = "${var.ENV}-public-rt"
#     type = "public"
#     ENV  = var.ENV
#   }
# }

# resource "aws_route_table_association" "public" {
#   subnet_id      = aws_subnet.public.id
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_eip" "nat" {
#   vpc = true

#   tags = {
#     Name = "${var.ENV}-nat-eip"
#     ENV  = var.ENV
#   }
# }

# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public.id

#   tags = {
#     Name = "${var.ENV}-nat-gw"
#     ENV  = var.ENV
#   }
# }

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat.id
#   }

#   tags = {
#     Name = "${var.ENV}-private-rt"
#     type = "private"
#     ENV  = var.ENV
#   }
# }

# resource "aws_route_table_association" "private" {
#   count          = length(var.cidr_private)
#   subnet_id      = aws_subnet.private[count.index].id
#   route_table_id = aws_route_table.private.id
# }

