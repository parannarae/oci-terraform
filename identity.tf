resource "oci_identity_compartment" "develop" {
  compartment_id = var.tenancy_id
  description    = "Compartment for active development"
  name           = "develop"
}
