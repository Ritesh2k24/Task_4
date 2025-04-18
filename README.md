# Task_4
Automate Strapi Deployment with GitHub Actions + Terraform

🚀 Strapi Deployment using GitHub Actions, Terraform, Docker & AWS ECR

This project automates the deployment of a Strapi CMS application on an AWS EC2 instance using:

1. Docker to containerize the application

2. AWS ECR to store the Docker image

3. Terraform to provision infrastructure

4. GitHub Actions to build, push, and deploy via CI/CD

  

⚙️ How it Works

1. CI Workflow (ci.yml)

   
Triggers on push to master branch (I have used master)

Builds the Docker image for the Strapi app

Pushes it to AWS ECR


2. CD Workflow (terraform.yml)


Triggered manually (workflow_dispatch)

Runs terraform init, plan, and apply

Launches an EC2 instance with Docker

Pulls the latest Strapi image from ECR and runs it
