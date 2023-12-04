# variable definitions for gcp project 
variable "project_id" {
    type = string
    description = "the id for the gcp project"
    # default =  "term-project-406220"
    default =  "term-project-v2"
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

variable "machine_type" {
  description = "VM instance machine type."
  type        = string
  default     = "f1-micro"
}

variable "ssh_public_key" {
  description = "ssh public key for ssh into compute instace"
  type        = string
  sensitive   = true
}