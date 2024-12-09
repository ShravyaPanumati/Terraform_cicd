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
    startup-script = <<-EOT
      #! /bin/bash
      sudo apt-get update
      sudo apt-get install -y python3 python3-pip nginx google-cloud-sdk

      # Download index.html from GCS
      gsutil cp gs://${var.bucket_name}/index.html /var/www/html/index.html

      # Restart Nginx
      sudo systemctl restart nginx

      # Ensure Nginx is enabled to start on boot
      sudo systemctl enable nginx
    EOT
  }
}

# Add firewall rule to allow HTTP traffic (port 80)
resource "google_compute_firewall" "default" {
  name    = "allow-http"
  network = google_compute_network.default.name

  allow {
    ports = ["80"]
  }

  target_tags = ["http-server"]

  source_ranges = ["0.0.0.0/0"]  # Allow traffic from any IP
}
