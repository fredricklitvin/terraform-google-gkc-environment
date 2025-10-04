variable subnet_id {
  type        = string
  description = "subnet id where vm will be created"
}

variable zone {
  type        = string
  description = "zone where vm will be created"
  default = "us-central1-a"
}

variable mechine_type_bastion {
  type        = string
  default     = "e2-small"
  description = "the mechine type of the bastion"
}

variable firewall_host_tag {
  type        = string
  default     = "bastion"
  description = "firewall tag of the bastion host "
}

variable vm_name {
  type        = string
  default     = "bastion"
  description = "the name of the vm"
}

variable image_type {
  type        = string
  default     = "debian-cloud/debian-12"
  description = "image type of the vm "
}

variable project_labels {
  description = "Key/value labels applied to the project"
  type        = map(string)
  default     = {
  env         = "dev"
  app         = "bastion"
  owner       = "me"
  managed_by  = "terraform"
  }
 
}