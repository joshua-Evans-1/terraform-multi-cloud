resource "aws_security_group" "allow-all-egress" {
  vpc_id      = aws_vpc.vpc_network.id
  name        = "allow-all-egress"
  description = "security group that allows and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-all-egress"
  }
}

resource "aws_security_group" "allow-ssh" {
  vpc_id      = aws_vpc.vpc_network.id
  name        = "allow-ssh"
  description = "security group that allows ingress by ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
  }
}

resource "aws_security_group" "allow-icmp" {
  vpc_id      = aws_vpc.vpc_network.id
  name        = "allow-icmp"
  description = "security group allows icmp in & out (for ping)"
  egress {
    protocol    = "icmp"
  }

  ingress {
    protocol    = "icmp"
  }
  tags = {
    Name = "allow-icmp"
  }
}

# Why RDP? needed for site-to-site VpN: https://docs.aws.amazon.com/vpn/latest/s2svpn/SetUpVPNConnections.html#vpn-configure-security-groups
resource "aws_security_group" "allow-rdp" {
  vpc_id       = aws_vpc.vpc_network.id
  name         = "allow-rdp"
  description  = "allow RDP (ingress)"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  tags = {
    Name = "allow-rdp"
  }

}

# resource "aws_security_group" "private-ssh" {
#   vpc_id      = aws_vpc.vpc_network.id
#   name        = "private-ssh"
#   description = "security group for private that allows ssh and all egress traffic"
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     security_groups = [ aws_security_group.bastion-allow-ssh.id ]
#   }
#   tags = {
#     Name = "private-ssh"
#   }
# }