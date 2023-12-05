variable "vpc_cidr_block" {
    type = string
    description = "Subnet CIDR/ Prefix"
}

variable "instance_type" {
  description = "EC2 instance machine type"
  type        = string
  default     = "t2.micro"
}

# How to choose an AMI instance: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
variable "ami" {
  description = "AMI (operating system) for EC2 instance"
  type        = string
  default     = "ami-0230bd60aa48260c6"
}

# SSH keys for EC2 instance
variable "aws_public_key_pair" {
	type = object({
    key_name = string
    public_key = string
  })
	description = "aws_key_pair for EC2"
}