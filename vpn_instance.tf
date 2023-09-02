##### security group  #####

resource "oci_core_network_security_group" "openvpn" {
  compartment_id = oci_identity_compartment.develop.id
  vcn_id         = oci_core_vcn.dev.id

  display_name = "openvpn"
}

resource "oci_core_network_security_group_security_rule" "openvpn_admin_web" {
  network_security_group_id = oci_core_network_security_group.openvpn.id
  direction                 = "INGRESS"
  protocol                  = "6"

  description = "Admin Web UI"
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = var.openvpn_admin_port
      max = var.openvpn_admin_port
    }
  }
}

resource "oci_core_network_security_group_security_rule" "openvpn_tcp" {
  network_security_group_id = oci_core_network_security_group.openvpn.id
  direction                 = "INGRESS"
  protocol                  = "6"

  description = "OpenVPN TCP tunnel"
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_network_security_group_security_rule" "openvpn_udp" {
  network_security_group_id = oci_core_network_security_group.openvpn.id
  direction                 = "INGRESS"
  protocol                  = "17"

  description = "OpenVPN UDP tunnel"
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"

  udp_options {
    destination_port_range {
      min = 1194
      max = 1194
    }
  }
}

##### compute instance #####

# import {
#     to = oci_core_instance.open_vpn2
#     id = ""
# }

resource "oci_core_instance" "open_vpn2" {
  availability_domain = var.instance_availability_domain
  compartment_id      = oci_identity_compartment.develop.id
  shape               = "VM.Standard.E2.1.Micro"

  display_name = "open_vpn2"

  create_vnic_details {
    subnet_id = oci_core_subnet.dev_public.id
    nsg_ids   = [oci_core_network_security_group.openvpn.id]
  }

  source_details {
    source_type = "image"
    source_id   = var.openvpn_as_image_id
  }

  preserve_boot_volume = false

  metadata = {
    ssh_authorized_keys = file("${var.vpn_instance_public_key_path}")
  }
}

# Change resource name
moved {
  from = oci_core_instance.open_vpn1
  to   = oci_core_instance.open_vpn2
}

# resource "oci_core_instance" "open_vpn3" {
#   availability_domain = var.instance_availability_domain
#   compartment_id      = oci_identity_compartment.develop.id
#   shape               = "VM.Standard.E2.1.Micro"

#   display_name = "open_vpn3"

#   create_vnic_details {
#     subnet_id = oci_core_subnet.dev_public.id
#     nsg_ids   = [oci_core_network_security_group.openvpn.id]
#   }

#   source_details {
#     source_type = "image"
#     source_id   = var.openvpn_as_image_id
#   }

#   preserve_boot_volume = false

#   metadata = {
#     ssh_authorized_keys = file("${var.vpn_instance_public_key_path}")
#   }
# }
