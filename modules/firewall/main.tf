resource "google_compute_firewall" "bastion_firewall_ssh" {
  name        = "bastion-firewall-ssh"
  network     = var.vpc_network_id
  description = "Creates firewall rule allowing ssh access to bastion host"

  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags = [var.firewall_host_tag]
}