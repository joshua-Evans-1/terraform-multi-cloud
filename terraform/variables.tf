
# gcp variables
variable "gcp_credentials_file_name" {
    type = string
    description = "the file name of the gcp credentials file"
}

variable "gcp_region_name" {
    type = string
    description = "region to deploy the gcp instance in"
}

variable "gcp_project_id" {
    type = string
    description = "our gcp prject id"
}

variable "gcp_network_name" {
    type = string
    description = "the name of the gcp network"
}

variable "gcp_subnet_cidr" {
    type = string
    description = "Subnet CIDR/ Prefix"
}