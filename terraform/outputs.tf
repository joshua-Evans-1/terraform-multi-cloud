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

output "gcp_ssh_command" {
    value = " ssh -i ${module.key.private_key_filename} ${module.gcp.gcp_ssh_username}@<IP> "
}

output "ec2_ssh_command" {
    value = " ssh -i ${module.key.private_key_filename} ec2-user@<IP> "
}