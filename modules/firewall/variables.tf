variable vpc_network_id {
  type        = string
  description = "created vpc network id"
}

variable firewall_host_tag {
  type        = string
  default     = "bastion"
  description = "firewall tag of the bastion host "
}
