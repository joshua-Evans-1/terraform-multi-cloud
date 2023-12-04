resource "google_compute_ha_vpn_gateway" "gcp-gateway" {
    name        = "${var.name}-ha-gateway"
    network     = var.gcp_vpc_id
}

resource "google_compute_external_vpn_gateway" "external_gateway" {
    name            = "aws"
    redundancy_type = "FOUR_IPS_REDUNDANCY"
    project         = var.project_id
    dynamic "interface" {
        for_each = local.external_vpn_gateway_interfaces
        content {
            id         = interface.key
            ip_address = interface.value["tunnel_address"]
        }
    }
}

resource "google_compute_router" "router" {
    name        = "${var.name}router"
    network     = var.gcp_vpc_id

    bgp{
        asn                = var.gcp_asn
        advertise_mode    = "CUSTOM"
        advertised_ip_ranges {
            range = var.gcp_subnet_cidr
        }
    } 
}

resource "google_compute_vpn_tunnel" "vpn_tunnel" {
    for_each                        = local.external_vpn_gateway_interfaces

    name                            = "gcp-tunnel${each.key}"
    description                     = "Tunnel to AWS - HA VPN interface ${each.key} to AWS interface ${each.value.tunnel_address}"
    router                          = google_compute_router.router.self_link
    ike_version                     = 2
    shared_secret                   = each.value.shared_secret
    vpn_gateway                     = google_compute_ha_vpn_gateway.gcp-gateway.self_link
    vpn_gateway_interface           = each.value.vpn_gateway_interface
    peer_external_gateway           = google_compute_external_vpn_gateway.external_gateway.self_link
    peer_external_gateway_interface = each.key

    depends_on = [
        google_compute_router.router,
        google_compute_ha_vpn_gateway.gcp-gateway,
        google_compute_external_vpn_gateway.external_gateway
    ]
}

resource "google_compute_router_interface" "interfaces" {
  for_each   = local.external_vpn_gateway_interfaces

  name       = "interface${each.key}"
  router     = google_compute_router.router.name
  ip_range   = each.value.cgw_inside_address
  vpn_tunnel = google_compute_vpn_tunnel.vpn_tunnel[each.key].name

  depends_on = [
        google_compute_router.router,
        google_compute_vpn_tunnel.vpn_tunnel,
    ]
}

resource "google_compute_router_peer" "router_peers" {
  for_each        = local.external_vpn_gateway_interfaces

  name            = "peer${each.key}"
  router          = google_compute_router.router.name
  peer_ip_address = each.value.vgw_inside_address
  peer_asn        = each.value.asn
  interface       = google_compute_router_interface.interfaces[each.key].name

  depends_on = [
        google_compute_router.router,
        google_compute_router_interface.interfaces,
    ]
}

locals {
    external_vpn_gateway_interfaces = {
        "0" = {
            tunnel_address        = aws_vpn_connection.vpn1.tunnel1_address
            vgw_inside_address    = aws_vpn_connection.vpn1.tunnel1_vgw_inside_address
            asn                   = aws_vpn_connection.vpn1.tunnel1_bgp_asn
            cgw_inside_address    = "${aws_vpn_connection.vpn1.tunnel1_cgw_inside_address}/30"
            shared_secret         = aws_vpn_connection.vpn1.tunnel1_preshared_key
            vpn_gateway_interface = 0
        },
        "1" = {
            tunnel_address        = aws_vpn_connection.vpn1.tunnel2_address
            vgw_inside_address    = aws_vpn_connection.vpn1.tunnel2_vgw_inside_address
            asn                   = aws_vpn_connection.vpn1.tunnel2_bgp_asn
            cgw_inside_address    = "${aws_vpn_connection.vpn1.tunnel2_cgw_inside_address}/30"
            shared_secret         = aws_vpn_connection.vpn1.tunnel2_preshared_key
            vpn_gateway_interface = 0
        },
        "2" = {
            tunnel_address        = aws_vpn_connection.vpn2.tunnel1_address
            vgw_inside_address    = aws_vpn_connection.vpn2.tunnel1_vgw_inside_address
            asn                   = aws_vpn_connection.vpn1.tunnel1_bgp_asn
            cgw_inside_address    = "${aws_vpn_connection.vpn2.tunnel1_cgw_inside_address}/30"
            shared_secret         = aws_vpn_connection.vpn2.tunnel1_preshared_key
            vpn_gateway_interface = 1
        },
        "3" = {
            tunnel_address        = aws_vpn_connection.vpn2.tunnel2_address
            vgw_inside_address    = aws_vpn_connection.vpn2.tunnel2_vgw_inside_address
            asn                   = aws_vpn_connection.vpn1.tunnel2_bgp_asn
            cgw_inside_address    = "${aws_vpn_connection.vpn2.tunnel2_cgw_inside_address}/30"
            shared_secret         = aws_vpn_connection.vpn2.tunnel2_preshared_key
            vpn_gateway_interface = 1
        }
    }
}