VPN Implementation
==================
We create a Site-to-Site VPN on AWS and on GCP to connect VPC's across the two clouds.


```
vpn
├── aws_gateway.tf
├── gcp_gateway.tf
└── variables.tf
```
## AWS Side VPN
The VPN connection is a "Site-to-Site VPN", with IPv4. 

The AWS side of the connection is a VPN gateway (in/out of public subnet). It is connected to two endpoints on the Google side, and the AWS-side VPN gateway manages both connections.


## GCP Side VPN

in order to implement a vpn connection on gcp we need

Cloud Router: 
* Cloud Router is a fully distributed and managed Google Cloud service that helps you define custom dynamic routes and scales with your network 
* provides dynamic routing using BGP for the network

HA VPN gateway:
* Each HA VPN gateway is a regional resource that has two interfaces, each with its own external IP addresses: interface 0 and 1.

VPN tunnels: 
* Connections from the HA VPN gateway to the peer VPN gateway on AWS through which encrypted traffic passes.

    Outside IP address for virtual private gateway for connection 1, tunnel 1

    Outside IP address for virtual private gateway for connection 1, tunnel 2
    
    Outside IP address for virtual private gateway for connection 2, tunnel 1
    
    Outside IP address for virtual private gateway for connection 2, tunnel 2

Peer VPN gateway: 
* Two AWS Site-to-Site VPN endpoints, which are from an AWS virtual private gateway 
