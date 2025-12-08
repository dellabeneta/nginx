# Data Source para AMI Amazon Linux 2
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 5. Servidor (EC2)
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id

  # Security Groups devem ser passados como lista de IDs
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Perfil IAM para permitir acesso via SSM
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name

  # Criptografia do volume raiz (Melhoria de Segurança)
  root_block_device {
    encrypted = true
  }

  tags = merge(local.common_tags, {
    Name = "web-server"
  })
}
