variable "oci_cli_profile" {
  type = string
}

variable "oci_region" {
  type    = string
  default = "ap-chuncheon-1"
}

variable "instance_availability_domain" {
  type    = string
  default = "tikl:AP-CHUNCHEON-1-AD-1"
}

variable "tenancy_id" {
  type      = string
  sensitive = true
}

variable "openvpn_admin_port" {
  type      = number
  sensitive = true
}

variable "vpn_instance_public_key_path" {
  type        = string
  sensitive   = true
  description = "A path to a public key to ssh vpn instance"
}

variable "openvpn_as_image_id" {
  type = string
  # Version: 2.11.3
  default     = "ocid1.image.oc1..aaaaaaaa7zusgdqsvykmh774gwv77nlcznph2qsjy7f2ywrvmlidpnpc7faq"
  description = "OpenVPN Acess Server Marketplace Image"
}
