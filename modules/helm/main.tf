
resource "helm_release" "argocd" {
  provider = helm 
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  timeout = 300

  values = [
    file("argocd-values.yaml")
  ]
}


data "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-argocd-server" 
    namespace = helm_release.argocd.namespace
  }
  depends_on = [helm_release.argocd]
}

output "argocd_server_host" {
  description = "The external IP or hostname for the Argo CD server LoadBalancer."
  value = try(
    coalesce(
      data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].hostname,
      data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].ip
    ),
    "LoadBalancer IP/Hostname is pending. Run 'kubectl get svc -n argocd' after apply."
  )
}
