terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.44.0"
    }
  }
  backend "gcs" {}
}

module network {
  source = "./modules/network"
}

module firewall {
  source = "./modules/firewall"
  vpc_network_id = module.network.vpc_network_id
}

module vm {
  source = "./modules/vm"
  subnet_id = module.network.private_subnet_id
  zone = "us-central1-a"
}