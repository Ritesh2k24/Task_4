#!/bin/bash
apt update -y
apt install -y docker.io
systemctl start docker
systemctl enable docker

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 905418107991.dkr.ecr.us-east-1.amazonaws.com

docker pull 905418107991.dkr.ecr.us-east-1.amazonaws.com/strapi-app:latest
docker run -d -p 1337:1337 905418107991.dkr.ecr.us-east-1.amazonaws.com/strapi-app:latest
