output "network_id" {
    value = google_compute_network.project_network.id
}

# network_interface.0.access_config.0.nat_ip - If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip (if you didn't provide one).
# from docs: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#attributes-reference
output "gcp_vm_public_ip" {
    value = google_compute_instance.vm.network_interface.0.access_config.0.nat_ip
}

# network_interface.0.network_ip - The internal ip address of the instance, either manually or dynamically assigned.
output "gcp_vm_private_ip" {
    value = google_compute_instance.vm.network_interface.0.network_ip
}

output "gcp_ssh_username" {
    value = "${split("@", data.google_client_openid_userinfo.me.email)[0]}"
}