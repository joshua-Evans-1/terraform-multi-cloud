# =========== Keys ========= #

# Generate TLS Key
resource "tls_private_key" "bastion_instance_key" {
	algorithm = "RSA"
}

# Creat AWS Instance Key 
resource "aws_key_pair" "bastion_instance_key" {
	key_name = var.bastion_key_name
	public_key = tls_private_key.bastion_instance_key.public_key_openssh
	depends_on = [
		tls_private_key.bastion_instance_key	
	]
}

# Save Private Key
resource "local_file" "bastion_instance_key" {
	content = tls_private_key.bastion_instance_key.private_key_pem
	filename = var.bastion_key_name
	file_permission = "0400"
	
	depends_on = [
		tls_private_key.bastion_instance_key
	]

}

# ========== Launch EC2 instance(s) ========= #
resource "aws_instance" "bastion-host" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [
    aws_security_group.allow-all-egress.id,
    aws_security_group.allow-ssh.id,
    aws_security_group.allow-ping.id,
    aws_security_group.allow-rdp.id,
   ]

  key_name = aws_key_pair.bastion_instance_key.key_name

  tags = {
            Name = "bastion-host"
        }
  
  depends_on = [
		aws_subnet.public_subnet,
    aws_security_group.allow-all-egress,
    aws_security_group.allow-ssh,
    aws_security_group.allow-ping,
    aws_security_group.allow-rdp
	]
}
