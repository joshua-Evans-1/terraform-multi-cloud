output "network_id" {
    value = google_compute_network.project_network.id
}

output "nginx_ip" {
    value = google_compute_instance.vm.network_interface.0.access_config.0.nat_ip
}