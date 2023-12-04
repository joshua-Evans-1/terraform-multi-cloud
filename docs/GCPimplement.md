GCP Implementation
==================

## terraform initialization
inside our [main.tf](../terraform/main.tf) file we need to specify our provider and define a module for GCP.

provider specification
```tf main.tf
terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "~> 4.51.0"
        }
    }
}

provider "google" {
    region      = var.gcp_region_name
    credentials = file(var.gcp_cred_file)
    project     = var.gcp_project_id
}
```
module definition

```tf main.tf
module "gcp" {
    source              = "./modules/gcp"
    subnet_cidr         = var.gcp_subnet_cidr
    network_name        = var.gcp_network_name
}
```
## GCP Module 

inside our [modules directory](../terraform/modules/) we create a directory named gcp.
```sh
mkdir /terraform/modules/gcp
```

## Files
inside our gcp module directory we create our files 

```sh 
touch network.tf output.tf variables.tf compute.tf
```
our [gcp directory](../terraform/modules/gcp/) should now look like:
```tree
gcp
├── network.tf
├── output.tf
├── compute.tf
└── variables.tf
```
### network.tf
inside our [network.tf](../terraform/modules/gcp/network.tf) file we define our vpc and subnets and firewalls
```tf network.tf
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

## this creates firewall rules to enable ssh on our gcp vpc
# FYI great security rules reference: 
# https://kbrzozova.medium.com/basic-firewall-rules-configuration-in-gcp-using-terraform-a87d268fa84f

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
```
### output.tf
inside our [output.tf](../terraform/modules/gcp/output.tf) file we define our output variables
```tf output.tf
output "network_id" {
    value = google_compute_network.project_network.id
}

# network_interface.0.access_config.0.nat_ip - If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip (if you didn't provide one).
# from docs: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#attributes-reference
output "gcp_vm_public_ip" {
    value = google_compute_instance.vm.network_interface.0.access_config.0.nat_ip
}

# network_interface.0.network_ip - The internal ip address of the instance, either manually or dynamically assigned.
output "gcp_vm_private_ip" {
    value = google_compute_instance.vm.network_interface.0.network_ip
}

output "gcp_ssh_username" {
    value = "${split("@", data.google_client_openid_userinfo.me.email)[0]}"
}
```
### variables.tf
inside our [variables.tf](../terraform/modules/gcp/variables.tf) file we define our terraform variables
```tf variables.tf
# variable definitions for gcp project 
variable "project_id" {
    type = string
    description = "the id for the gcp project"
    # default =  "term-project-406220"
    default =  "term-project-v2"
}

variable "network_name" {
    type = string
    description = "the name of the gcp Network Name"
    default = "project"
}

variable "subnet_cidr" {
    type = string
    description = "Subnet CIDR/ Prefix"
}

variable "machine_type" {
  description = "VM instance machine type."
  type        = string
  default     = "f1-micro"
}

variable "ssh_public_key" {
  description = "ssh public key for ssh into compute instace"
  type        = string
  sensitive   = true
}
```
inside our [compute.tf](../terraform/modules/gcp/compute.tf) file we define a virtual machine inside gcp
```
data "google_client_openid_userinfo" "me" {}

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
        subnetwork = google_compute_subnetwork.subnet.id
        access_config {
        }
    }

    metadata = {
        ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${var.ssh_public_key}"
    }

    metadata_startup_script = file("${path.module}/startup_script.sh")
    depends_on = [ google_compute_subnetwork.subnet ]
}
```