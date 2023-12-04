resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
	key_name = "terraform-public-key-pair"
	public_key = tls_private_key.ssh_key.public_key_openssh
	depends_on = [
		tls_private_key.ssh_key
	]
}

resource "local_file" "keyfile" {
	content = tls_private_key.ssh_key.private_key_pem
	filename = "key.pem"
	file_permission = "0400"
	
	depends_on = [
		tls_private_key.ssh_key
	]

}
