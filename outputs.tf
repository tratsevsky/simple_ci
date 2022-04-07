output "ip" {
  description = IP address of the GCP Compute instance"
  value = google_compute_instance.devserver.network_interface.0.network_ip
}
