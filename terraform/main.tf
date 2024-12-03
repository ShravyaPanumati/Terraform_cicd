resource "google_compute_instance" "flask-app" {
  name         = "flask-app-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  project      = "strategic-reef-435523-j1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"  # Use a more recent Debian image
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
