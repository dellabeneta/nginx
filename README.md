# Nginx Infrastructure Project
This project provisions an Nginx server on AWS using Terraform, deploys a static site from the app directory via S3, and configures DNS with Cloudflare.

## Prerequisites
Terraform >= 1.0.0
AWS CLI configured
Cloudflare Account (Token and Zone ID)

## Configuration
Create terraform/terraform.tfvars with your Cloudflare credentials.
cloudflare_api_token = "YOUR_TOKEN"
cloudflare_zone_id   = "YOUR_ZONE_ID"
variable notification_email defaults to <EMAIL_ADDRESS>.

## Usage
Navigate to the terraform directory.
Run terraform init to download providers.
Run terraform apply to create infrastructure.
Confirm the AWS SNS subscription email received on first run.

## Architecture
EC2 Instance (t3.micro, Amazon Linux 2) with Nginx.
S3 Bucket for application file storage.
IAM Role for SSM access and S3 syncing.
Cloudflare A Record pointing to the instance IP.
SNS Topic for deployment notifications.

## Access
The application will be available at <URL_ADDRESS>
Manage the server via AWS Systems Manager (SSM).
Logs are available in /var/log/user-data.log and /var/log/nginx/.
