output "argocd_server_host" {
  description = "Argo CD endpoint ip address."
  value       = module.helm.argocd_server_ip
}
