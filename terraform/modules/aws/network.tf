# Internet Gateway
resource "aws_internet_gateway" "internet_gw" {
    vpc_id = aws_vpc.vpc_network.id

    depends_on = [
        aws_vpc.vpc_network
    ]
}

# An Elastic IP (EIP) for use by the NAT gateway
resource "aws_eip" "nat_gateway_public_ip"{
    domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
    # associate NAT gw with an elastic IP address
    allocation_id = aws_eip.nat_gateway_public_ip.id
    subnet_id     = aws_subnet.public_subnet.id

    depends_on = [
        aws_eip.nat_gateway_public_ip,
        aws_subnet.public_subnet,
    ]
}

####### Route Tables
# A route table contains a set of rules, called routes, that determine where network traffic from your subnet or gateway is directed.
# Each route in a table specifies a destination and a target


## PUBLIC Route Table
# allows public subnet to access internet via internet gateway
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc_network.id

    # To enable a subnet to access the internet through an internet gateway, add the following route to your subnet route table:
    # { destination : 0.0.0.0/0 , target : your internet gw id }
    # 0.0.0.0/0 represents all IPv4 addresses
    # the target is the igw that's attached to your VPC
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gw.id
    }

    depends_on = [
        aws_internet_gateway.internet_gw,
        aws_vpc.vpc_network,
    ]
}

# Associate Public Route Table w/ Public Subnet
resource "aws_route_table_association" "public_route_table_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id

    depends_on     = [
        aws_subnet.public_subnet,
        aws_route_table.public_route_table,
    ]
}

# PRIVATE Route Table
# "The private route table is associated with the private subnets which enables the private subnets to interact with the internet." WHYYYY?????
# I'm not sure that we need a private route table taht connects to the internet??? like why do w have this???
# resource "aws_route_table" "private_route_table" {
#     vpc_id = aws_vpc.vpc_network.id
#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_nat_gateway.nat_gw.id
#     }

#     depends_on = [
#         aws_vpc.vpc_network,
#         aws_nat_gateway.nat_gw
#     ]
# }


# ## Private Route Table Association => Private subnets
# resource "aws_route_table_association" "private_route_table_association" {
#     count          = length(data.aws_availability_zones.available.names)
#     subnet_id      = element(aws_subnet.private_subnet.*.id,count.index)
#     route_table_id = aws_route_table.private_route_table.id

#     depends_on = [
#         aws_subnet.private_subnet,
#         aws_route_table.private_route_table,
#     ]
# }

