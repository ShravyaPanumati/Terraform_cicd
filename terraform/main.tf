provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_sql_database_instance" "default" {
  name             = "example-instance"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "default" {
  name     = "flask_db"
  instance = google_sql_database_instance.default.name
}

resource "google_sql_user" "default" {
  name     = "root"
  instance = google_sql_database_instance.default.name
  password = "password123"
}

resource "google_compute_network" "default" {
  name = "flask-network"
}

resource "google_compute_instance" "default" {
  name         = "flask-app"
  machine_type = "e2-micro"
  zone         = var.zone  # Add zone here

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230509"
    }
  }

  network_interface {
    network = google_compute_network.default.name
  }

  metadata = {
    startup-script = <<EOT
      #! /bin/bash
      sudo apt-get update
      sudo apt-get install -y python3 python3-pip
      pip3 install -r /path/to/requirements.txt
      python3 run.py
    EOT
  }
}
