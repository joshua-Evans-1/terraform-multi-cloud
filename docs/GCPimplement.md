GCP Implementation
==================


## terraform initialization
inside our [main.tf](../terraform/main.tf) file we need to specify our provider and define a module for GCP.

provider specification
```tf main.tf
provider "google" {
    version = "~> 3.38"
}
```
module definition

```tf main.tf
module "gcp_cloud" {
    source                 = "./modules/gcp"
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
touch network.tf output.tf variables.t
```
```tree
gcp
├── network.tf
├── output.tf
└── variables.tf
```
### network.tf
inside our [network.tf](../terraform/modules/gcp/network.tf) file we define our vpc and subnets
```tf network.tf
## this creates our VPC Network inside gcp
resource "google_compute_network" "app_network" {
    name                    = "${var.network_name}-vpc"
    auto_create_subnetworks = false
}

## this creates Subnets
resource "google_compute_subnetwork" "app_subnet" {
    name          = "${var.network_name}-subnet"
    ip_cidr_range = var.subnet_cidr
    network       = "${var.network_name}-vpc"
    
    depends_on    = [
        google_compute_network.app_network
    ]
}
```
### output.tf
inside our [output.tf](../terraform/modules/gcp/output.tf) file we define our output variables

### variables.tf
inside our [variables.tf](../terraform/modules/gcp/variables.tf) file we define our terraform variables

ex. 
```tf variables.tf
variable "project_id" {
    type = string
    description = "the id for the gcp project"
    default =  "term-project"
}
```
