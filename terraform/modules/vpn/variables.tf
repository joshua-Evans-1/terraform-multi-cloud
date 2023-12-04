# variable definitions for our vpn module
variable "name" {
    type = string
    description = "AWS-GCP vpn name"
    default = "gcp-aws-vpn"
}

variable "aws_vpc_id" {
    type = string
    description = "id from aws vpc"
}

variable "gcp_vpc_id" {
    type = string
    description = "id from gcp network"
}

variable "aws_route_table_ids" {
    type = list(string)
    description = "route table ids from aws public and private"
}

variable "project_id" {
    type = string
    description = "the id for the gcp project"
    default =  "term-project-406220"
}