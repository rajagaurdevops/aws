variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-0f9de6e2d2f067fca"  # Ubuntu 22.04 LTS (Change if needed)
}

variable "instance_type" {
  default = "t3.micro"
}

variable "deployer_public_key" {
  description = "SSH Public Key Content"
  type        = string
}
