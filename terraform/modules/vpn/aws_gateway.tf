
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

resource "aws_customer_gateway" "google" {
    bgp_asn = 65000
    ip_address = google_compute_address.vpn_ip.address
    type = "ipsec.1"

    depends_on = [
        google_compute_address.vpn_ip,
    ]
}

resource "aws_vpn_connection" "connection" {
    vpn_gateway_id = aws_vpn_gateway.gateway.id
    customer_gateway_id = aws_customer_gateway.google.id
    type = "ipsec.1"
    static_routes_only = false

    depends_on = [
        aws_vpn_gateway.gateway,
        aws_customer_gateway.google,
    ]
}
