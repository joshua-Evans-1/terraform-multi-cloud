
# In AWS, a VPN gateway connects a 'VPN tunnel' to a VPV
# So, a VPN gateway is the AWS side of the tunnel
resource "aws_vpn_gateway" "gateway"{
    vpc_id = var.aws_vpc_id
}

resource "aws_vpn_gateway_route_propagation" "route_propagation" {
    count = length(var.aws_route_table_ids)
    route_table_id = element(var.aws_route_table_ids,count.index)
    vpn_gateway_id = aws_vpn_gateway.gateway.id

    depends_on = [
        aws_vpn_gateway.gateway,
    ]
}

# Customer Gateway (CGW) represents a physical device or a software application on the customer’s side of the VPN connection
# so from AWS's pespective, the CGW is the Google side of the tunnel

resource "aws_customer_gateway" "customer_gateway1" {
  bgp_asn    = var.gcp_asn
  ip_address = google_compute_ha_vpn_gateway.gcp-gateway.vpn_interfaces[0].ip_address
  type       = "ipsec.1"

  depends_on = [
        google_compute_ha_vpn_gateway.gcp-gateway,
    ]
}

resource "aws_customer_gateway" "customer_gateway2" {
  bgp_asn    = var.gcp_asn
  ip_address = google_compute_ha_vpn_gateway.gcp-gateway.vpn_interfaces[1].ip_address
  type       = "ipsec.1"

  depends_on = [
        google_compute_ha_vpn_gateway.gcp-gateway,
    ]
}

# Creates a VPN connection between the AWS side VPN gateway, and the GCP side Customer gateway
resource "aws_vpn_connection" "vpn1" {
  vpn_gateway_id      = aws_vpn_gateway.gateway.id
  customer_gateway_id = aws_customer_gateway.customer_gateway1.id
  type                = aws_customer_gateway.customer_gateway1.type
  static_routes_only  = false

  depends_on = [
        aws_vpn_gateway.gateway,
        aws_customer_gateway.customer_gateway1,
    ]
}

resource "aws_vpn_connection" "vpn2" {
  vpn_gateway_id      = aws_vpn_gateway.gateway.id
  customer_gateway_id = aws_customer_gateway.customer_gateway2.id
  type                = aws_customer_gateway.customer_gateway2.type
  static_routes_only  = false

  depends_on = [
        aws_vpn_gateway.gateway,
        aws_customer_gateway.customer_gateway2,
    ]
}
