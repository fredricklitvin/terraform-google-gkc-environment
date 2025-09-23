resource "google_compute_firewall" "bastion_firewall_ssh" {
  name        = "bastion-firewall-ssh"
  network     = var.vpc_network_id
  description = "Creates firewall rule allowing ssh access to bastion host"

  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags = ["bastion"]
}
resource "google_compute_firewall" "bastion_firewall_office" {
  name        = "bastion-firewall-office"
  network     = var.vpc_network_id
  description = "Creates firewall rule allowing ssh access to bastion host"

  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }

  source_ranges = ["83.130.132.85/32"]
  target_tags = ["bastion"]
}