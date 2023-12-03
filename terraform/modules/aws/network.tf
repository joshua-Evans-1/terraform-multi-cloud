## Internet Gateway
resource "aws_internet_gateway" "application_igw" {
    vpc_id = aws_vpc.vpc_network.id

    depends_on = [
        aws_vpc.vpc_network
    ]
}

## Nat Gateway
resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_public_ip.id
    subnet_id     = aws_subnet.public_subnets.0.id

    depends_on = [
        aws_eip.nat_public_ip,
        aws_subnet.public_subnets,
    ]
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc_network.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.application_igw.id
    }

    depends_on = [
        aws_internet_gateway.application_igw,
        aws_vpc.vpc_network,
    ]
}

## Private Route Table
resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.vpc_network.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw.id
    }

    depends_on = [
        aws_vpc.vpc_network,
        aws_nat_gateway.nat_gw
    ]
}

## Public Route Table Association => Public-Subnets
resource "aws_route_table_association" "public_route_table_association" {
    count          = length(data.aws_availability_zones.available.names)
    subnet_id      = element(aws_subnet.public_subnets.*.id,count.index)
    route_table_id = aws_route_table.public_route_table.id

    depends_on     = [
        aws_subnet.public_subnets,
        aws_route_table.public_route_table,
    ]
}

## Private Route Table Association => Private subnets
resource "aws_route_table_association" "private_route_table_association" {
    count          = length(data.aws_availability_zones.available.names)
    subnet_id      = element(aws_subnet.private_subnets.*.id,count.index)
    route_table_id = aws_route_table.private_route_table.id

    depends_on = [
        aws_subnet.private_subnets,
        aws_route_table.private_route_table,
    ]
}

