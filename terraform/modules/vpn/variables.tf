variable "aws_vpc_id" {
    type = string
    description = "id from aws vpc"
}

variable "aws_route_table_ids" {
    type = list(string)
    description = "route table ids from aws public and private"
}

variable "gcp_network_id" {
    type = string
    description = "id from gcp network"
}