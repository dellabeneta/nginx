resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Permitir SSH e HTTP"
  vpc_id      = aws_vpc.main.id



  ingress {
    description = "HTTP de qualquer lugar"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "web-sg"
  })
}
