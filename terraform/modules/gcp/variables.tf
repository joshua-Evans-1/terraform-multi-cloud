# variable definitions for gcp project 
variable "project_id" {
    type = string
    description = "the id for the gcp project"
    default =  "term-project-406220"
}

variable "network_name" {
    type = string
    description = "the name of the gcp Network Name"
    default = "project"
}

variable "subnet_cidr" {
    type = string
    description = "Subnet CIDR/ Prefix"
}

