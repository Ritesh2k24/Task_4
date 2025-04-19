#!/bin/bash
apt-get update -y
apt-get install -y docker.io awscli


systemctl enable docker
systemctl start docker

# Login to ECR
$(aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 905418107991.dkr.ecr.us-east-1.amazonaws.com)

# Pull and run Strapi Docker image
docker pull 905418107991.dkr.ecr.us-east-1.amazonaws.com/strapi-app:latest
docker run -d -p 1337:1337 905418107991.dkr.ecr.us-east-1.amazonaws.com/strapi-app:latest

