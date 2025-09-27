output "cluster_endpoint" {
  description = "The IP address of the cluster control plane's endpoint."
  value       = google_container_cluster.default.endpoint
}

output "cluster_ca_certificate" {
  description = "Base64 encoded public certificate authority."
  value       = module.gke_cluster.cluster_ca_certificate
}