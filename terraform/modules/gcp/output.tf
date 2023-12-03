output "network_id" {
    value = google_compute_network.app_network.id
}

output "gke_config" {
    value = data.google_client_config.current_config
}
