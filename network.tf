##### vcn #####

resource "oci_core_vcn" "dev" {
  compartment_id = oci_identity_compartment.develop.id
  display_name   = "dev-vcn"
  cidr_blocks    = ["10.0.0.0/16"]
}

resource "oci_core_subnet" "dev_private" {
  compartment_id = oci_identity_compartment.develop.id
  vcn_id         = oci_core_vcn.dev.id
  cidr_block     = "10.0.1.0/24"

  display_name = "private subnet-dev-vcn"
}

resource "oci_core_subnet" "dev_public" {
  compartment_id = oci_identity_compartment.develop.id
  vcn_id         = oci_core_vcn.dev.id
  cidr_block     = "10.0.0.0/24"

  display_name = "public subnet-dev-vcn"
}
