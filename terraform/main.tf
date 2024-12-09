provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "default" {
  name = "flask-network"
}

resource "google_compute_instance" "default" {
  name         = "flask-app"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230509"
    }
  }

  network_interface {
    network = google_compute_network.default.name
    access_config {} # Enable external access
  }

  metadata = {
    startup-script = <<EOT
      #! /bin/bash
      sudo apt-get update
      sudo apt-get install -y python3 python3-pip
      # Update this path to where the actual requirements.txt will be
      pip3 install -r /path/to/requirements.txt
      python3 /path/to/run.py
    EOT
  }
}

output "instance_name" {
  description = "The name of the Compute Engine instance"
  value       = google_compute_instance.default.name
}

output "instance_external_ip" {
  description = "The external IP address of the Compute Engine instance"
  value       = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}
