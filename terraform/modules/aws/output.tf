output "vpc_id" {
    value = aws_vpc.vpc_network.id
}

output "nat_gateway_public_ip" {
	value = aws_eip.nat_gateway_public_ip.public_ip 
}

output "public_subnet"{
    value = aws_subnet.public_subnet.id
}

output "private_subnet" {
    value = aws_subnet.private_subnet.id
}

output "public_subnet_cidr_block" {
	value = aws_subnet.public_subnet.cidr_block 
}

output "private_subnet_cidr_block"{
    value = aws_subnet.private_subnet.cidr_block
}

output "public_route_table_id" {
    value = aws_route_table.public_route_table.id
}

# output "private_route_table_id" {
#     value = aws_route_table.private_route_table.id
# }
