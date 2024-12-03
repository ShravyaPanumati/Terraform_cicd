provider "google" {
  project = "YOUR_PROJECT_ID"
  region  = "us-central1"
  zone    = "us-central1-a"
}

# Create a Cloud SQL MySQL instance
resource "google_sql_database_instance" "default" {
  name             = "flask-sql-db"
  database_version = "MYSQL_8_0"
  region           = "us-central1"

  root_password = "your_password"

  settings {
    tier = "db-f1-micro"
  }
}

# Create a Compute Engine instance to host the Flask app
resource "google_compute_instance" "flask-app" {
  name         = "flask-app-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y python3-pip python3-dev
    sudo apt-get install -y mysql-client
    pip3 install -r /path/to/your/app/requirements.txt
    python3 /path/to/your/app/run.py
  EOT
}
