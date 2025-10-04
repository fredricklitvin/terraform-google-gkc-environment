resource "google_compute_instance" "bastion" {
  name         = var.vm_name
  machine_type = var.mechine_type_bastion
  zone         = var.zone

  tags = [var.firewall_host_tag]
  labels = var.project_labels

  boot_disk {
    initialize_params {
      image = var.image_type
      labels = var.project_labels
      
    }
  }
  network_interface {
    subnetwork = var.subnet_id
  }
  }