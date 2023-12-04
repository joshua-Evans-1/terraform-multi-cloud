## this creates our VPC Network inside gcp
resource "google_compute_network" "project_network" {
    name                    = "${var.network_name}-vpc"
    auto_create_subnetworks = false
}

## this create our subnets
resource "google_compute_subnetwork" "subnet" {
    name          = "${var.network_name}-subnet"
    ip_cidr_range = var.subnet_cidr
    network       = "${var.network_name}-vpc"
    depends_on    = [ google_compute_network.project_network ]
}

resource "google_compute_subnetwork" "vm_subnet" {
    name          = "${var.network_name}-subnet-vm"
    ip_cidr_range = "10.0.1.0/24"
    network       = "${var.network_name}-vpc"
    depends_on    = [ google_compute_network.project_network ]
}

## this creates firewall rules to enable ssh on our gcp vpc
# FYI great security rules reference: 
# https://kbrzozova.medium.com/basic-firewall-rules-configuration-in-gcp-using-terraform-a87d268fa84f
# TODO: reserch         priority = "65534" if ICMP doesn't work
resource "google_compute_firewall" "ssh-rule" {
    name    = "${var.network_name}sshrule"
    network = google_compute_network.project_network.name
    allow {
        protocol = "tcp"
        ports    = ["22","80","443"]

    }
    # allow ping
    allow {
        protocol = "icmp"
    }
    source_ranges = ["0.0.0.0/0"]
    depends_on = [ google_compute_network.project_network ]
}

resource "google_compute_instance" "vm" {
    name = "${var.network_name}-vm"
    machine_type = var.machine_type
    zone         = "us-east1-b"
    tags         = ["http-server"]
    
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = google_compute_network.project_network.id
        subnetwork = google_compute_subnetwork.vm_subnet.id
        access_config {
        }
    }
    metadata_startup_script = file("${path.module}/nginx_install.sh")
    depends_on = [ google_compute_subnetwork.vm_subnet ]
}