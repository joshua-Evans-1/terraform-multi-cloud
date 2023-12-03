# variable definitions for gcp project 

variable "project_id" {
    type = string
    description = "the id for the gcp project"
    default =  "term-project"
}

variable "network_name" {
    type = string
    description = "the name of the gcp Network Name"
    default = "gcp-application"
}

variable "subnet_cidr" {
    type = string
    description = "Subnet CIDR/ Prefix"
}

variable "pods_network_cidr" {
    type = string
    description = "Pods Subnet CIDR/ Prefix"
}

variable "services_network_cidr" {
    type = string
    description = "Services Subnet CIDR/ Prefix"
}

variable "cluster_name"{
    type = string
    description = "Cluster Name"
}

variable "cluster_zone"{
    type = string
    description = "CLuster Zone name"
}
