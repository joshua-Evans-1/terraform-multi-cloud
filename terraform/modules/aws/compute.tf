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

  key_name = var.aws_public_key_pair.key_name

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
