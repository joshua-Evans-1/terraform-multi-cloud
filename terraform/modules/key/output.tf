output "private_key" {
  value = tls_private_key.ssh_key.private_key_pem
  sensitive=true
}

output "public_key" {
  value = tls_private_key.ssh_key.public_key_openssh
  sensitive=true
}

output "aws_public_key_pair" {
  value = aws_key_pair.key_pair
}

output "private_key_filename" {
  value = local_file.keyfile.filename
}