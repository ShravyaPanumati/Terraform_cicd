provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "flask-app" {
  name         = "flask-app"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {} # Enables external IP
  }

  metadata_startup_script = <<EOT
#!/bin/bash
sudo apt-get update
sudo apt-get install -y python3-pip
pip3 install flask
EOT
}

resource "google_sql_database_instance" "default" {
  name             = "example-instance"
  database_version = "MYSQL_5_7"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}
