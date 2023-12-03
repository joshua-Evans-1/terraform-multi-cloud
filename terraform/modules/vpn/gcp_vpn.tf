resource "google_compute_address" "vpn_ip" {
    name        = var.name
}

resource "google_compute_ha_vpn_gateway" "gcp-gateway" {
    name        = "${var.name}-ha-gateway"
    network     = var.gcp_vpc_id
}

resource "google_compute_external_vpn_gateway" "external_gateway" {
  name            = "aws"
  redundancy_type = "SINGLE_IP_INTERNALLY_REDUNDANT"
  project = var.project_id
      interface {
    id            = 0
    ip_address = aws_vpn_connection.aws_to_gcp.tunnel1_address
  }
}


## Google Compute Router
resource "google_compute_router" "router" {
    name        = "${var.name}router"
    network     = var.gcp_vpc_id

    bgp{
        asn     = aws_customer_gateway.google.bgp_asn
    } 

    depends_on  = [
        aws_customer_gateway.google,
    ]
}


resource "google_compute_vpn_tunnel" "vpn_tunnel" {
    name                            = "${var.name}-tunnel"
    vpn_gateway                     = google_compute_ha_vpn_gateway.gcp-gateway.id
    peer_external_gateway           = google_compute_external_vpn_gateway.external_gateway.id
    shared_secret                   = aws_vpn_connection.aws_to_gcp.tunnel1_preshared_key
    router                          = google_compute_router.router.id
    vpn_gateway_interface           = 0
    peer_external_gateway_interface = 0
    depends_on = [
        google_compute_ha_vpn_gateway.gcp-gateway,
        aws_vpn_connection.aws_to_gcp,
        google_compute_external_vpn_gateway.external_gateway
    ]
}

## Computer Router Interface

resource "google_compute_router_interface" "gcp_vpn_router_interface" {
    name        = "${var.name}-router-interface"
    router      = google_compute_router.router.name
    ip_range    = "${aws_vpn_connection.aws_to_gcp.tunnel1_cgw_inside_address}/30"
    vpn_tunnel  = google_compute_vpn_tunnel.vpn_tunnel.name

    depends_on  = [
        google_compute_vpn_tunnel.vpn_tunnel,
        aws_vpn_connection.aws_to_gcp
    ]
}

## Router Peer
resource "google_compute_router_peer" "gcp_vpn_router_peer" {
    name = "${var.name}-bgp1"
    router = google_compute_router.router.name
    peer_ip_address = aws_vpn_connection.aws_to_gcp.tunnel1_vgw_inside_address
    peer_asn = aws_vpn_connection.aws_to_gcp.tunnel1_bgp_asn  
    interface  = google_compute_router_interface.gcp_vpn_router_interface.name

    depends_on = [
        google_compute_router_interface.gcp_vpn_router_interface,
        google_compute_router.router,
    ]
}