output "instance-id" {
  description = "ID of the GCP Compute instance"
  value = google_compute_instance.dev[count.index].id
}

output "private-ip" {
  description = "Private IP address of the GCP Compute instance"
  value = google_compute_instance.dev[count.index].network_interface.0.network_ip
}

output "public-ip" {
  description = "Public IP address of the GCP Compute instance"
  value = google_compute_address.static.address
}
