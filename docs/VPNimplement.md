VPN Implementation
==================
we create a VPN on AWS and on GCP that connect to eachother 

## terraform initialization
inside our [main.tf](../terraform/main.tf) file we need to define a module for our vpn.
```tf main.tf
module "vpn" {
    source = "./modules/vpn"
    aws_vpc_id = module.aws_cloud.vpc_id
    aws_route_table_ids = [module.aws_cloud.public_route_table_id, module.aws_cloud.private_route_table_id]
    gcp_network_id = module.gcp_cloud.network_id
}
```
## Module vpn

inside our [modules directory](../terraform/modules/) we create a directory named vpn.
```sh
mkdir /terraform/modules/vpn
```

## Files
inside our [vpn directory](../terraform/modules/vpn/) we create our files 

```sh 
touch gcp_vpn.tf aws_vpn.tf variables.tf
```
our [vpn directory](../terraform/modules/vpn/) should now look like:
```
vpn
├── aws_vpn.tf
├── gcp_vpn.tf
└── variables.tf
```
## AWS VPN

## GCP VPN
