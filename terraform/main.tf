provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "strapi_sg" {
  name        = "strapi_sg"
  description = "Allow Strapi ports"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "strapi" {
  ami                    = var.ami_id
  instance_type          = "t2.medium"
  key_name               = "master"
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    aws_access_key_id     = var.aws_access_key_id,
    aws_secret_access_key = var.aws_secret_access_key
  })

  tags = {
    Name = "strapi-instance"
  }
}
