AWS Implementation
==================

## VPC
VPC = virtual private cloud.

region = a [cluster of data centers](https://aws.amazon.com/about-aws/global-infrastructure/regions_az/). e.g. us-east-2, us-west-1, etc.

AZ (availablity zone) = a discrete data center

--------
Copy paste from this tutorial that I'm following to build AWS VPC (for reference): https://spacelift.io/blog/terraform-aws-vpc

### i will write it myself as i build

A VPC spans all the Availability Zones (AZ) in a region. It is always associated with a CIDR range (both IPv4 and IPv6) which defines the number of internal network addresses that may be used internally.

>> Recall: CIDR blocks. A [CIDR block](https://aws.amazon.com/what-is/cidr/) is a collection of IP addresses that share the same network prefix and number of bits. 

Within the VPC, we create subnets that are specific to AZs. It is possible to have multiple subnets in the same AZ. The purpose of subnets is to internally segregate resources contained in the VPC in every AZ. AWS Regions consist of multiple Availability Zones for DR purposes.

When a VPC is created, a corresponding Route Table is also created, which defines a default route that lets the components in the VPC communicate with each other internally. The route table thus created is called the main route table.

Our architecture contains two types of subnets – public and private. Public subnets enable internet access for the components hosted within them, while private subnets don’t. Routes in the route tables drive the decision to enable or disable internet access. When a subnet is associated with a route table that allows internet access, it is called a public subnet. Whereas the subnet associated with the route table that does not allow internet access is called private subnet.

An internet gateway is deployed and associated with the VPC to enable internet traffic within the VPC’s public subnets. Only one internet gateway can be associated with each VPC. Owing to this, and the fact that there is usually a default internet address (0.0.0.0/0) pointing to the internet gateway, as a best practice, it is recommended to create a second route table.

Thus apart from the main route table, our architecture consists of a second route table to which public subnets are explicitly associated. 
--------