output "instance_name" {
  description = "The name of the Compute Engine instance"
  value       = google_compute_instance.default.name
}

output "instance_external_ip" {
  description = "The external IP address of the Compute Engine instance"
  value       = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}
