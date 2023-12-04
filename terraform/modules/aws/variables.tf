variable "vpc_cidr_block" {
    type = string
    description = "Subnet CIDR/ Prefix"
}

variable "instance_type" {
  description = "EC2 instance machine type."
  type        = string
  default     = "t2.micro"
}

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
variable "ami" {
  description = "AMI (operating system) for EC2 instance"
  type        = string
  default     = "ami-0230bd60aa48260c6"
}

variable "bastion_key_name" {
	type = string
	description = "Bastion Instance Key Name"
    default = "aws_bastion_key"
}