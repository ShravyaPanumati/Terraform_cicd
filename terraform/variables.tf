variable "project_id" {
  description = "strategic-reef-435523-j1"
  type        = string
}

variable "region" {
  description = "The region for GCP resources"
  default     = "us-central1"
}

variable "db_username" {
  description = "The username for the Cloud SQL database"
  type        = string
  default     = "root"
}

variable "db_password" {
  description = "The password for the Cloud SQL database"
  type        = string
  default     = "password123"  # Replace with a secure password
}

variable "db_name" {
  description = "The name of the database in the Cloud SQL instance"
  type        = string
  default     = "flask_db"
}

