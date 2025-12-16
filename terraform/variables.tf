variable "aws_region" {
  description = "A região AWS para provisionar os recursos"
  type        = string
  default     = "sa-east-1"
}

variable "vpc_cidr" {
  description = "O bloco CIDR para a VPC"
  type        = string
  default     = "192.168.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "O valor deve ser um bloco CIDR IPv4 válido (ex: 10.0.0.0/16)."
  }
}

variable "public_subnet_cidr" {
  description = "O bloco CIDR para a Subnet Pública"
  type        = string
  default     = "192.168.1.0/24"

  validation {
    condition     = can(cidrhost(var.public_subnet_cidr, 0))
    error_message = "O valor deve ser um bloco CIDR IPv4 válido (ex: 10.0.1.0/24)."
  }
}

variable "instance_type" {
  description = "O tipo de instância EC2"
  type        = string
  default     = "t3.micro"
}

variable "notification_email" {
  description = "Email para receber notificações do Terraform"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Token da API da Cloudflare com permissão de edição de DNS"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "ID da Zona DNS na Cloudflare (Zone ID)"
  type        = string
}


