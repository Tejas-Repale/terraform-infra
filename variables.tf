variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "my-terraform-project"
}

variable "owner" {
  description = "Owner of the project"
  type        = string
  default     = "tejas"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
  default     = ["subnet-0123456789abcdef0"] # Optional: Replace or override with tfvars
}
