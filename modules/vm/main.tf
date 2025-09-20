resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "e2-small"
  zone         = var.zone

  tags = ["bastion"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      labels = {
        my_label = "value"
      }
    }
  }


  network_interface {
    subnetwork = var.subnet_id

    access_config {
    }
  }
  }