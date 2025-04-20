variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "aws_access_key_id" {
  type = string
}

variable "aws_secret_access_key" {
  type = string
}
