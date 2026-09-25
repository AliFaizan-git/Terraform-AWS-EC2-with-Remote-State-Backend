variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (Amazon Linux 2023, eu-north-1)"
  type        = string
}

variable "key_name" {
  description = "Name of the AWS key pair for SSH access"
  type        = string
}

variable "public_key_path" {
  description = "Path to your local public SSH key file (.pub)"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into the instance (your IP, not 0.0.0.0/0)"
  type        = string
}

variable "environment" {
  description = "Deployment environment tag"
  type        = string
  default     = "dev"
}