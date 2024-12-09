# Provider configuration
provider "google" {
  project = var.project_id
  region  = var.region
}

# Create a Google Cloud Storage bucket to host the application
resource "google_storage_bucket" "static_site" {
  name     = "${var.project_id}-static-site"
  location = var.region
  force_destroy = true

  website {
    main_page_suffix = "index.html"
  }
}

# Grant public access to the bucket contents
resource "google_storage_bucket_iam_binding" "public" {
  bucket = google_storage_bucket.static_site.name

  role = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

# Output the bucket URL
output "bucket_url" {
  value = "https://storage.googleapis.com/${google_storage_bucket.static_site.name}"
}
