resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = merge(var.default_tags, {
    Name = var.vpc_name
  })
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  count = length(data.aws_availability_zones.available.zone_ids)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone_id    = data.aws_availability_zones.available.zone_ids[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.default_tags, {
    Name = "public-subnet-${count.index}"
  })
}


resource "aws_subnet" "private" {
  count = length(data.aws_availability_zones.available.zone_ids)

  vpc_id               = aws_vpc.main.id
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]
  cidr_block           = "10.0.${length(data.aws_availability_zones.available.zone_ids) + count.index}.0/24"

  tags = merge(var.default_tags, {
    Name = "private-subnet-${count.index}"
  })
}

resource "aws_eip" "ngw" {
  count = length(aws_subnet.private)

  vpc = true

  tags = merge(var.default_tags, {
    Name = "${var.vpc_name}"
  })
}

resource "aws_nat_gateway" "gw" {
  count = length(aws_subnet.private)

  allocation_id = aws_eip.ngw[count.index].id
  subnet_id     = aws_subnet.private[count.index].id

  tags = merge(var.default_tags, {
    Name = "${var.vpc_name}-nat-gateway"
  })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags, {
    Name = "${var.vpc_name}-internet-gateway"
  })
}

resource "aws_route_table" "private" {
  count  = length(aws_nat_gateway.gw)
  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags, {
    Name = "${var.vpc_name}-private-subnets"
  })
}

resource "aws_route" "private" {
  count = length(aws_nat_gateway.gw)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw[count.index].id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}




