# Terraform Multi-Cloud Networking (SDN)
A project that utilizes terraform to create and deploy a highly available VPN connections between Google Cloud (GCP) and Amazon Web Services (AWS) for direct communication between VPC networks across the two cloud platforms.


## Table of Contents

* [Setup](docs/setup.md)
* Implementation
    * [Terraform](/docs/terraformimplementation.md)
    * [GCP module](docs/GCPimplement.md)
    * [AWS module](/docs/AWSimplement.md)
    * [VPN module](/docs/VPNimplement.md)
* [Deployment](#deployment)

## Project structure 
### cloud infastructure diagram
![diagram](/docs/diagram.jpg)

### terraform project structure
```
TERRAFORM-MULTI-CLOUD
.
├── README.md
├── docs
│   ├── AWSimplement.md
│   ├── GCPimplement.md
│   ├── VPNimplement.md
│   ├── diagram.jpg
│   ├── setup.md
│   └── terraformimplementation.md
└── terraform
    ├── main.tf
    ├── modules
    │   ├── aws
    │   │   ├── compute.tf
    │   │   ├── network.tf
    │   │   ├── output.tf
    │   │   ├── securitygroup.tf
    │   │   ├── variables.tf
    │   │   └── vpc.tf
    │   ├── gcp
    │   │   ├── compute.tf
    │   │   ├── network.tf
    │   │   ├── output.tf
    │   │   ├── startup_script.sh
    │   │   └── variables.tf
    │   ├── key
    │   │   ├── keygen.tf
    │   │   └── output.tf
    │   └── vpn
    │       ├── aws_gateway.tf
    │       ├── gcp_gateway.tf
    │       └── variables.tf
    ├── outputs.tf
    ├── terraform.tfvars
    └── variables.tf
```
## Deployment 
Navigate to `terraform` project directory (the one that contains `main.tf`)

after setup and implementation is complete 
```sh
terraform init 
```
to deploy the cloud infrastructure
```sh
terraform apply
```

to destroy the cloud infrastructure
```sh
terraform destroy
```

--------------------------

