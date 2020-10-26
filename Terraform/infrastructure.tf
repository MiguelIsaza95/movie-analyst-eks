provider "aws" {
  region = var.region
}

resource "aws_vpc" "test" {
  cidr_block           = var.vpc_address
  tags                 = var.vpc_tags
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "dmz_public" {
  vpc_id                  = aws_vpc.test.id
  count                   = length(var.public_subnet_zone)
  cidr_block              = element(var.public_subnet_address, count.index)
  map_public_ip_on_launch = "true"
  availability_zone       = element(var.public_subnet_zone, count.index)
  tags = {
    Name                                     = element(var.public_subnet_zone, count.index)
    Type                                     = "public"
    "kubernetes.io/cluster/eks_cluster_tuto" = "shared"
    "kubernetes.io/role/elb"                 = "1"
  }
}

resource "aws_subnet" "clusterprivate" {
  vpc_id                  = aws_vpc.test.id
  count                   = length(var.cluster_subnet_zone)
  cidr_block              = element(var.cluster_subnet_address, count.index)
  map_public_ip_on_launch = "false"
  availability_zone       = element(var.cluster_subnet_zone, count.index)
  tags = {
    Name                                     = element(var.cluster_subnet_zone, count.index)
    Type                                     = "private"
    "kubernetes.io/cluster/eks_cluster_tuto" = "shared"
    "kubernetes.io/role/internal-elb"        = "1"
  }
}

resource "aws_route_table" "nat_route" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat.id
  }

  tags = {
    Name = "main route"
  }
}

resource "aws_route_table" "internet_route" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "internet route"
  }
}

resource "aws_main_route_table_association" "vpc_main_route" {
  vpc_id         = aws_vpc.test.id
  route_table_id = aws_route_table.nat_route.id
}

resource "aws_route_table_association" "clusterprivate_subnet_association" {
  count          = length(aws_subnet.clusterprivate.*.id)
  subnet_id      = element(aws_subnet.clusterprivate.*.id, count.index)
  route_table_id = aws_route_table.nat_route.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.dmz_public.*.id)
  subnet_id      = element(aws_subnet.dmz_public.*.id, count.index)
  route_table_id = aws_route_table.internet_route.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "Internet Gateway"
  }
}