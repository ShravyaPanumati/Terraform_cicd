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
      sudo apt-get install -y python3 python3-pip nginx google-cloud-sdk

      # Download index.html from GCS
      gsutil cp gs://${var.bucket_name}/index.html /var/www/html/index.html

      # Start Nginx
      sudo systemctl restart nginx
    EOT
  }
}
