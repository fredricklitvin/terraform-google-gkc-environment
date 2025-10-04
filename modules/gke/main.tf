resource "google_service_account" "gke_node_sa" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}
resource "google_project_iam_member" "gke_node_binding" {
  for_each = var.gke_node_roles
  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}

resource "google_container_cluster" "default" {
  name = var.cluster_name
  location = var.region
  enable_autopilot = false
  deletion_protection = false
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false 
    master_ipv4_cidr_block  = var.private_master_ipv4
  }
  master_authorized_networks_config {
    cidr_blocks {
      display_name = "my-workstation"
      cidr_block   = var.master_authorized_cidr_block   # use curl -4 ifconfig.me to get it
    }
  }
  node_config {
    service_account = google_service_account.gke_node_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  network    = var.vpc_network_id
  subnetwork = var.private_subnet_id
  ip_allocation_policy {
    stack_type                    = "IPV4"
    services_secondary_range_name = var.secondary_ip_range_1
    cluster_secondary_range_name  = var.secondary_ip_range_0
  }
  initial_node_count = var.node_count
  
}

# resource "google_container_node_pool" "gke_node_pool" {
#   name       = "gke-node-pool"
#   location   = var.region
#   cluster    = google_container_cluster.default.name
#   node_count = var.node_count

#   node_config {
#     preemptible  = true
#     machine_type = "e2-medium"
#     disk_type    = "pd-standard"
#     disk_size_gb = 10

#     service_account = google_service_account.gke_node_sa.email
#     oauth_scopes    = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#   }
# }


