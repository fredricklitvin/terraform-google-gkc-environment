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
  }
  backend "gcs" {
    bucket =  "terraform-state-fred"
    prefix = "terraform/gkc-state"
  }
}
provider "google" {
  project = "i-agility-465314-p6"
  region  = var.region
}

data "google_client_config" "provider" {}


provider "helm" {
  kubernetes {
    host = "https://${module.gke_cluster.cluster_endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(
        module.gke_cluster.cluster_ca_certificate    
      )
  }
}