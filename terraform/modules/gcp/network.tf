## this creates our VPC Network inside gcp
resource "google_compute_network" "app_network" {
    name                    = "${var.network_name}-vpc"
    auto_create_subnetworks = false
}

## Create Subnets
resource "google_compute_subnetwork" "app_subnet" {
    name          = "${var.network_name}-subnet"
    ip_cidr_range = var.subnet_cidr
    network       = "${var.network_name}-vpc"
    
    depends_on    = [
        google_compute_network.app_network
    ]
}
