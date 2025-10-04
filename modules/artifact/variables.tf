variable artifact_name {
  type        = set(string)
  default     = [
    "terraform-artifact-repo",
    "terraform-artifact-repo-2",
  ]
  description = "a list of artifact registry names to create"
}
variable region {
  description = "The GCP region for the Artifact Registry."
  type        = string
  default     = "us-central1"
}