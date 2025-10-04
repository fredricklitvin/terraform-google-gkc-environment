terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.44.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-state-fred"
    prefix = "terraform/gkc-state"
  }
}

provider "google" {
  project = "i-agility-465314-p6"
  region  = var.region
}


data "google_container_cluster" "this" {
  name       = "k8s"
  location   = var.region
  depends_on = [module.gke] 
}

data "google_client_config" "me" {}


provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.this.endpoint}"
  token                  = data.google_client_config.me.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.this.master_auth[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes = {
    host                   = "https://${data.google_container_cluster.this.endpoint}"
    token                  = data.google_client_config.me.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.this.master_auth[0].cluster_ca_certificate
    )
  }
}