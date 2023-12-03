# Terraform Multi-Cloud Networking (SDN)
A project that utilizes terraform to create and deploy a multi-cloud environment using amazon(AWS) and google cloud(GCP). terraform creates a vpn between the two cloud environments to connect them. 
## Table of Contents

* [Setup](docs/setup.md)
* Implementation
    * [Terraform](/docs/terraformimplementation.md)
    * [GCP module](docs/GCPimplement.md)
    * [AWS module](/docs/AWSimplement.md)
    * [VPN module](/docs/VPNimplement.md)
* [deployment](#deployment)

## Project structure 
```
TERRAFORM-MULTI-CLOUD
├── README.md
├── docs
│   ├── AWSimplement.md
│   ├── GCPimplement.md
│   ├── VPNimplement.md
│   ├── setup.md
│   └── terraformimplementation.md
└── terraform
    ├── main.tf
    ├── modules
    │   ├── aws
    │   │   ├── network.tf
    │   │   ├── output.tf
    │   │   ├── variables.tf
    │   │   └── vpc.tf
    │   ├── gcp
    │   │   ├── network.tf
    │   │   ├── output.tf
    │   │   └── variables.tf
    │   └── vpn
    │       ├── aws_vpn.tf
    │       ├── gcp_vpn.tf
    │       └── variables.tf
    ├── outputs.tf
    ├── terraform.tfvars
    └── variables.tf
```
## Deployment 

after setup and implementation is complete 
```sh
terraform init 
```
```sh
terraform apply
```

to destroy the project run 
```sh
terraform destroy
```

--------------------------

