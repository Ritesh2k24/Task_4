#!/bin/bash
sudo apt-get install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

sudo apt-get update -y
sudo apt-get install -y docker.io

mkdir -p /root/.aws

cat <<EOT >> /root/.aws/credentials
[default]
aws_access_key_id=${aws_access_key_id}
aws_secret_access_key=${aws_secret_access_key}
EOT

cat <<EOT >> /root/.aws/config
[default]
region=us-east-1
output=json
EOT


sudo systemctl enable docker
sudo systemctl start docker

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 905418107991.dkr.ecr.us-east-1.amazonaws.com

# Pull and run Strapi Docker image
sudo docker pull 905418107991.dkr.ecr.us-east-1.amazonaws.com/strapi-app:latest
sudo docker run -d -p 1337:1337 905418107991.dkr.ecr.us-east-1.amazonaws.com/strapi-app:latest
