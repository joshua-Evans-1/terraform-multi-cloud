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
touch gcp_gateway.tf aws_gateway.tf variables.tf
```
our [vpn directory](../terraform/modules/vpn/) should now look like:
```
vpn
├── aws_gateway.tf
├── gcp_gateway.tf
└── variables.tf
```
## AWS VPN



## GCP VPN

in order to implement a vpn connection on gcp we need

Cloud Router: 
* A fully distributed and managed Google Cloud service to provide dynamic routing using BGP for the network

HA VPN gateway:
* A Google-managed VPN gateway running on Google Cloud. Each HA VPN gateway is a regional resource that has two interfaces, each with its own external IP addresses: interface 0 and 1.

VPN tunnels: 
* Connections from the HA VPN gateway to the peer VPN gateway on AWS through which encrypted traffic passes.

Outside IP address for virtual private gateway for connection 1, tunnel 1
Outside IP address for virtual private gateway for connection 1, tunnel 2
Outside IP address for virtual private gateway for connection 2, tunnel 1
Outside IP address for virtual private gateway for connection 2, tunnel 2

Peer VPN gateway: 
* Two AWS Site-to-Site VPN endpoints, which are from an AWS virtual private gateway 


