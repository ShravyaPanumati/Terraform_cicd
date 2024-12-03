variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region for GCP resources"
  default     = "us-central1"
}
