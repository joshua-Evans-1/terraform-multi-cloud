# Have terraform generate an ssh key pair that we can use to ssh into the compute instances we create with that deployment.
# Note that the same pair is used for all compute instances - it's allowed! 
# The reason we do this is for our ease of testabillity. 

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
