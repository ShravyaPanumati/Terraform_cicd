output "instance_ip" {
  description = "The external IP address of the Flask app instance"
  value       = google_compute_instance.flask-app.network_interface[0].access_config[0].nat_ip
}

output "db_connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value       = google_sql_database_instance.default.connection_name
}
