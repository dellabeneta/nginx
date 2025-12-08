output "instance_public_ip" {
  description = "O endereço IP público da instância EC2"
  value       = aws_instance.web.public_ip
}

output "instance_id" {
  description = "O ID da instância EC2"
  value       = aws_instance.web.id
}
