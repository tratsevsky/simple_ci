output "ip" {
  description = "IP address of the GCP Compute instance"
  value = google_compute_instance.dev.network_interface.0.network_ip
}
