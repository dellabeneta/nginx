provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_record" "web_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "fsa"
  value   = aws_instance.web.public_ip
  type    = "A"
  proxied = true
  ttl     = 1 # Auto TTL when proxied seems to be preferred, or we can leave it to default. Cloudflare manages TTL for proxied records.
}
