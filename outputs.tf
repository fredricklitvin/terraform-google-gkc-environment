output "argocd_server_ip" {
  description = "Argo CD endpoint ip address."
  value       = "http://${module.helm.argocd_server_ip}:80"
}
