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