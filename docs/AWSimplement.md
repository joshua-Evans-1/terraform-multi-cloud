AWS Implementation
==================

## AWS Cloud Network (VPC)
**VPC**: virtual private cloud. a VPC spans all AZ' in a region

**region**: a [cluster of data centers](https://aws.amazon.com/about-aws/global-infrastructure/regions_az/). e.g. us-east-2, us-west-1, etc.

**AZ (availablity zone)**: a discrete data center

**[CIDR block](https://aws.amazon.com/what-is/cidr/)** : a collection of IP addresses that share the same network prefix and number of bits

--------
## aws module
in [main.tf](../terraform/main.tf) we create a module for our AWS cloud


```tf main.tf
module "aws" {
    source              = "./modules/aws"
    vpc_cidr_block      = var.aws_vpc_cidr_block
}
```
`aws_vps_cidr_block`, our block of IP addresses for the VPC is defined in `terraform.tfvars` - this defines the number of internal network addresses that may be used internally within our VPC




In public subnet, the instances launched can be accessed from outside the aws VPC network whereas, the instances launched in private subnet cannnot be accessed from outside vpc network. The project creates public and private subnets in each available availability zone. Instances launched in public subnets are defined to be assigned public IP automatically. The HCL code for priate subnets is shown below similiarly the public subnets can also be created.

#

--------
# todo: this is copypasted as ref, plz fix
Function: cidrsubnet

Terraform provides handy function called cidrsubnet which is able to calculate subnet address within the given IP network address space.

cidrsubnet(iprange, newbits, netnum) where:
```
iprange = CIDR of the virtual network
    172.10.1.0/23
newbits = the difference between subnet mask and network mask
    *27 - 23 = 4*
netnum = practically the subnet index
    0 = 172.10.0.0/27
    1 = 172.10.0.32/27
    2 = 172.10.0.64/27
    3 = 172.10.0.96/27
```

https://developer.hashicorp.com/terraform/language/functions/cidrsubnet

When we call cidrsubnet we also pass two additional arguments: newbits and netnum. newbits decides how much longer the resulting prefix will be in bits;

The netnum argument then decides what number value to encode into those four new subnet bits. 
