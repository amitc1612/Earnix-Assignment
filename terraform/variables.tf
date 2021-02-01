variable "region" {
  default     = "us-east-2"
  type        = string
  description = "AWS region"
}

variable "enable_ec2_env" {
  description = "Enable EC2 environment"
  type        = bool
  default     = true
}

variable "ec2_instance_count" {
  description = "Number of instances in EC2 environment"
  type        = number
  default     = 2
}