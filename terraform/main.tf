provider "google" {
  project = var.project_id
  region  = var.region
}

# Resource for an existing Compute instance
resource "google_compute_instance" "flask-app" {
  name         = "flask-app"  # The name of existing instance
  machine_type = "f1-micro"   # Machine type (ensure this matches the existing instance)

  zone         = "us-central1-a"  # Zone where your instance is located

  # Define network interface (This is required, even for an existing instance)
  network_interface {
    network = "default"
    access_config {}  # External IP
  }

  # Define boot disk (This is required, even for an existing instance)
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"  # Ensure this matches the existing instance's disk image
    }
  }

  metadata_startup_script = <<EOT
#!/bin/bash
sudo apt-get update
sudo apt-get install -y python3-pip
pip3 install flask
EOT
}
# Modify to manage the existing Cloud SQL instance
resource "google_sql_database_instance" "default" {
  #name             = "example-instance"  # Name of the existing Cloud SQL instance
  database_version = "MYSQL_5_7"         # The version should match the existing instance's version
  name     = var.db_name
  instance = google_sql_database_instance.default.name
  region           = var.region

  settings {
    tier = "db-f1-micro"  # Make sure this matches the tier of the existing instance
  }
}
