variable bucket_name {
  type        = string
  description = "bucket name for storing terraform state"
}

variable prefix_bucket {
  type        = string
  description = "prefix for state file"
}

variable name {
  type        = string
  default     = "us-central1"
  description = "region for the project"
}


