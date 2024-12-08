# variables.tf

variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The region for resources"
  type        = string
}

variable "zone" {
  description = "The zone where resources will be created"
  type        = string
  default     = "us-central1-a"  # Set a default value if desired
}
