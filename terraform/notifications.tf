resource "aws_sns_topic" "terraform_updates" {
  name = "terraform-updates-topic"
}

resource "aws_sns_topic_subscription" "email_target" {
  topic_arn = aws_sns_topic.terraform_updates.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "null_resource" "notify_deploy" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "aws sns publish --topic-arn ${aws_sns_topic.terraform_updates.arn} --message 'Terraform Apply Finalizado! \n\nInstancia ID: ${aws_instance.web.id}\nIP Publico: ${aws_instance.web.public_ip}\nRegiao: ${var.aws_region}' --region ${var.aws_region}"
  }

  depends_on = [aws_instance.web]
}
