# for getting your logged in google username - needed to create SSH key for the instance
data "google_client_openid_userinfo" "me" {}


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

    metadata = {
        ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${var.ssh_public_key}"
    }

    # Run a script when creating the instance to install a web server
    metadata_startup_script = file("${path.module}/startup_script.sh")

    depends_on = [ google_compute_subnetwork.subnet ]
}