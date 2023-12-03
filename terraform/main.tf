terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "~> 5.7.0"
        }
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.29.0"
        }
    }
}
provider "google" {
    project     = var.gcp_project_id
    region      = var.gcp_region_name
    credentials = file(var.gcp_credentials_file_name)
}

module "gcp_cloud" {
    source                 = "./modules/gcp"
    subnet_cidr            = var.gcp_subnet_cidr
    network_name           = var.gcp_network_name
}

module "vpn" {
    source = "./modules/vpn"
    aws_vpc_id = module.aws_cloud.vpc_id
    aws_route_table_ids = [module.aws_cloud.public_route_table_id, module.aws_cloud.private_route_table_id]
    gcp_network_id = module.gcp_cloud.network_id
}