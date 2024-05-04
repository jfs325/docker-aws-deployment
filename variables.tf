variable "region" {
  description = "The region where environment is going to be deployed"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

# VPC variables

variable "vpc_cidr" {
  description = "CIDR range for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ecr_task_container_image_arn" {
  description = "arn for ecr image"
  type = string
  default = "public.ecr.aws/o2u9j5x1/service-deploy:latest"
}