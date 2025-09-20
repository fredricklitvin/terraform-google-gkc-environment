resource "google_compute_firewall" "bastion_firewall" {
  name        = "bastion-firewall"
  network     = var.vpc_network_id
  description = "Creates firewall rule allowing ssh access to bastion host"

  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }

  source_ranges = ["149.106.151.229/32"]
  target_tags = ["bastion"]
}