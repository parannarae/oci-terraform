terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 5.11.0"
    }
  }
}

provider "oci" {
  region              = var.oci_region
  auth                = "SecurityToken"
  config_file_profile = var.oci_cli_profile
}
