variable "vpc_name" {
  type    = string
  default = "default"
}

variable "security_group_name" {
  type    = string
  default = "default"
}

variable "instance_type" {
  type    = string
  default = "t4g.medium"
}
