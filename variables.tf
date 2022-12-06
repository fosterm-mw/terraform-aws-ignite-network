
variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_cidr" {
  type = string
  default = "10.0.0.128/26"
}

variable "private_cidr" {
  type = string
  default = "10.0.0.192/26"
}

variable "private_failover_cidr" {
  type = string
  default = "10.0.2.0/24"
}

