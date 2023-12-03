## AWS Availability Zones
data "aws_availability_zones" "available" {
    state                   = "available"
}

## Backend Database Network
resource "aws_vpc" "vpc_network" {
    cidr_block              = var.vpc_cidr_block
}

## Subnets
resource "aws_subnet" "public_subnets" {
    vpc_id                  = aws_vpc.vpc_network.id
    count                   = length(data.aws_availability_zones.available.names)
    cidr_block              = cidrsubnet(var.vpc_cidr_block,8,count.index)
    availability_zone       = element(data.aws_availability_zones.available.names,count.index)
    map_public_ip_on_launch = true

    depends_on = [
        aws_vpc.vpc_network
    ]

}

resource "aws_subnet" "private_subnets" {
    vpc_id                  = aws_vpc.vpc_network.id
    count                   = length(data.aws_availability_zones.available.names)
    cidr_block              = cidrsubnet(var.vpc_cidr_block,8,"${10+count.index}")
    availability_zone       = element(data.aws_availability_zones.available.names,count.index)
    tags  = {
        Name                = "Private Subnet - ${element(data.aws_availability_zones.available.names,count.index)}"
    }

    depends_on = [
        aws_vpc.vpc_network
    ]
}

resource "aws_eip" "nat_public_ip"{
    domain = "vpc"
}
