# VPC 
# a VPC is always associated with a CIDR range, so we give it one
resource "aws_vpc" "vpc_network" {
    cidr_block              = var.vpc_cidr_block
}

# PUBLIC Subnet
# Create a public subnet within the VPC
# can be scaled to add more, but we are just doing one
resource "aws_subnet" "public_subnet" {
    vpc_id                  = aws_vpc.vpc_network.id
    
    # give the public subnet a public IP address
    map_public_ip_on_launch = true

    # assign a subset of the VPC's cidr block to the subnet
    cidr_block              = cidrsubnet(var.vpc_cidr_block,8,44)

    tags  = {
        Name                = "Public Subnet"
    }

    depends_on = [
        aws_vpc.vpc_network
    ]

}

# PRIVATE Subnet
# Create private a subnet within the VPC
resource "aws_subnet" "private_subnet" {
    vpc_id                  = aws_vpc.vpc_network.id

    # assign a subset of the VPC's cidr block to the subnet
    cidr_block              = cidrsubnet(var.vpc_cidr_block,8,22)

    tags  = {
        Name                = "Private Subnet"
    }

    depends_on = [
        aws_vpc.vpc_network
    ]
}