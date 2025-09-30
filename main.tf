

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

module "gke" {
  source = "./modules/gke"
  project = "i-agility-465314-p6"
  vpc_network_id = module.network.vpc_network_id
  private_subnet_id = module.network.private_subnet_id
  secondary_ip_range_1 = module.network.private_subnet_ip_range_1
  secondary_ip_range_0 = module.network.private_subnet_ip_range_0
  region = var.region
}

module "helm" {
  source = "./modules/helm"
  depends_on = [module.gke]
  providers  = { helm = helm, kubernetes = kubernetes }

}