provider "google" {
  project = var.project_id
  region  = var.region
}

# Modify to manage the existing instance
resource "google_compute_instance" "flask-app" {
  name         = "flask-app"  # Name of the existing instance
  machine_type = "f1-micro"   # You can keep the original type if it's the same

  zone         = "us-central1-a"  # Zone where your instance exists

  # Note: Remove disk and network settings if the instance already has a configuration
  # These should match the current settings of the existing instance, not change them.

  metadata_startup_script = <<EOT
#!/bin/bash
sudo apt-get update
sudo apt-get install -y python3-pip
pip3 install flask
EOT
}
# Modify to manage the existing Cloud SQL instance
resource "google_sql_database_instance" "default" {
  name             = "example-instance"  # Name of the existing Cloud SQL instance
  database_version = "MYSQL_5_7"         # The version should match the existing instance's version
  region           = var.region

  settings {
    tier = "db-f1-micro"  # Make sure this matches the tier of the existing instance
  }
}
