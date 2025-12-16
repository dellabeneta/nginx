output "instance_public_ip" {
  description = "O endereço IP público da instância EC2"
  value       = aws_instance.web.public_ip
}

output "instance_id" {
  description = "O ID da instância EC2"
  value       = aws_instance.web.id
}

output "bucket_name" {
  description = "Nome do bucket S3 onde a aplicacao esta armazenada"
  value       = aws_s3_bucket.app_bucket.id
}

output "website_url" {
  description = "URL completa de acesso ao site"
  value       = "http://${cloudflare_record.web_dns.hostname}"
}
