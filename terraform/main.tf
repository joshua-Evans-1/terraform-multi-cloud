terraform {
    required_providers {
        google = {
            source      = "hashicorp/google"
            version     = "~> 4.51.0"
        }
        aws = {
            source      = "hashicorp/aws"
            version     = "~> 5.29.0"
        }
    }
}

#PROVIDERS
provider "aws" {
    region              = var.aws_region
    profile             = var.aws_iAM
    shared_credentials_files = [var.aws_cred_file]
}

provider "google" {
    region              = var.gcp_region_name
    credentials         = file(var.gcp_cred_file)
    project             = var.gcp_project_id
}

#MODULES
module "gcp" {
    source              = "./modules/gcp"
    subnet_cidr         = var.gcp_subnet_cidr
    network_name        = var.gcp_network_name
}

module "aws" {
    source              = "./modules/aws"
    vpc_cidr_block      = var.aws_vpc_cidr_block
}

module "vpn" {
    source              = "./modules/vpn"
    gcp_vpc_id          = module.gcp.network_id
    aws_vpc_id          = module.aws.vpc_id
    aws_route_table_ids = [module.aws.public_route_table_id, module.aws.private_route_table_id]
    subnet_cidr         = var.gcp_subnet_cidr
}