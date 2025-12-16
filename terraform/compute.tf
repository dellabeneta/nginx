data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name

  root_block_device {
    encrypted = true
  }

  tags = merge(local.common_tags, {
    Name = "web-server"
  })

  user_data = templatefile("userdata.sh", {
    bucket_name = aws_s3_bucket.app_bucket.id
  })
}
