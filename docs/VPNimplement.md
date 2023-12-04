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
our [aws_gateway.tf](../terraform/modules/vpn/aws_gateway.tf) file creates an aws gateway resource and connects to our gcp gateway

| resource | name | description |
|---|---|---|
| aws_vpn_gateway | gateway | Provides a resource to create a VPC VPN Gateway. |
| aws_vpn_gateway_route_propagation | route_propagation | Requests automatic route propagation between a VPN gateway and a route table. |
|  aws_customer_gateway | google | Provides a customer gateway inside a VPC. These objects can be connected to VPN gateways via VPN connections, and allow you to establish tunnels between your network and google vpc. |
|  aws_vpn_connection | connection | Manages a Site-to-Site VPN connection. A Site-to-Site VPN connection is an Internet Protocol security (IPsec) |
## GCP VPN
our [gcp_gateway.tf](../terraform/modules/vpn/gcp_gateway.tf) creates a gateway, routing and vpn tunnel resources
| resource | name | description |
|---|---|---|
| google_compute_address | vpn_ip | To communicate with the Internet and instances outside of the same network, you must specify the instance's external IP address. |
| google_compute_ha_vpn_gateway | gcp-gateway| Represents a VPN gateway running in GCP. This virtual device is managed by Google, but used only by you. This type of VPN Gateway allows for the creation of VPN solutions with higher availability than classic Target VPN Gateways. |
| google_compute_external_vpn_gateway | external_gateway | Represents a VPN gateway managed outside of GCP. |
| google_compute_router | router | Represents a Router resource. |
| google_compute_vpn_tunnel vpn_tunnel | encrypts the clouds internet traffic between vpcs |
| google_compute_router_interface | router_interface | Manages a Cloud Router interface. | 
| google_compute_router_peer | router_peer | BGP information that must be configured into the routing stack to establish BGP peering. This information must specify the peer ASN and either the interface name, IP address, or peer IP address |
## variables
| name | description | type |
|---|---|---|
| name | AWS-GCP vpn name | string |
| aws_vpc_id | id from aws vpc | string |
| gcp_vpc_id | id from gcp network | string |
| aws_route_table_ids | route table ids from aws public and private | list(string) |
| project_id | the id for the gcp project | string |
