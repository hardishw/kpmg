variable "region" {
  description = "aws region to deploy to"
  default     = "eu-west-2"
}

variable "default_tags" {
  description = "tags to add to all created resources"
  default = {
    Environment = "dev"
    Team        = "devops"
  }
  type = map
}

variable "vpc_name" {
  default = "web-app"
}