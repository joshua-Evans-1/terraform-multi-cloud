resource "google_compute_instance" "vm" {
    name = "${var.network_name}-vm"
    machine_type = var.machine_type
    zone         = "us-east1-b"
    tags         = ["http-server"]
    
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = google_compute_network.project_network.id
        subnetwork = google_compute_subnetwork.subnet.id
        access_config {
        }
    }
    metadata_startup_script = file("${path.module}/nginx_install.sh")
    depends_on = [ google_compute_subnetwork.subnet ]
}