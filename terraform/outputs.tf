output "aws_bastion_public_ip" {
    value = module.aws.aws_bastion_public_ip
}

output "aws_bastion_private_ip" {
    value = module.aws.aws_bastion_private_ip
}

output "gcp_vm_public_ip" {
    value = module.gcp.gcp_vm_public_ip
}

output "gcp_vm_private_ip" {
    value = module.gcp.gcp_vm_private_ip
}