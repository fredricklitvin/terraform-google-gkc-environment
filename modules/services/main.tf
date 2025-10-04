locals { apis = [
  "container.googleapis.com","compute.googleapis.com","iam.googleapis.com",
  "artifactregistry.googleapis.com","cloudresourcemanager.googleapis.com",
  "dns.googleapis.com","secretmanager.googleapis.com",
]}
resource "google_project_service" "enabled" {
  for_each = toset(local.apis)
  project  = var.project
  service  = each.key
  disable_on_destroy = false
}